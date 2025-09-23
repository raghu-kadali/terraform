terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "~>5.0"
    }
  }
  
}




provider "google" {
  project = var.projectid
  region  = var.region
}


resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}





#you call module already in your local
module "vpc" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name #whatever wer write but calling name important
}

#call subnet module
module "subnet1" {
  source        = "./modules/subnet"
  subnet_name   = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  #pass the module output in the form  the module inpout module.modulelocalname.moduleoutput
  vpc_id     = module.vpc.output_vpcid
  region     = var.region
  depends_on = [ module.vpc ]
}

#call gce module
module "gce" {
  source       = "./modules/gce"
  vm_name      = var.vm_name
  zone         = var.zone
  machine_type = var.machine_type
  image        = var.image
  subnet_id    = module.subnet1.output_subnet_id

}




 