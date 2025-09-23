
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.2.0"
    } #terraform starting version or required vers is ">=1.3.0"
  }
  # required_version = ">=1.3.0"

  backend "gcs" {
    bucket = "review-today"
    prefix = "stage/prod-stage"


  }
}




 provider "google" {
  project = "terraform-project-470306"
  region = "us-central1"
  zone = "us-central1-c"

}


 resource "google_compute_instance" "vm" {
  count        = 2
  name         = "dev-vm${count.index}"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["ssh"]
}


#create 2 vpc in my own names
variable "vpc_names"{
    default = ["vpc2","vpc3"]
}

resource "google_compute_network" "my_net" {
    count = length(var.vpc_names)
    name = var.vpc_names[count.index]
}

#in map(string) only one iteration came
# map(object ) multiple configurations

variable "more_vms"{
   type = map(object (
        {
            machine_type = string
            zone = string
            boot_size_gb = number

        }
    ))
    default = {
        web-app = {
            machine_type = "e2-micro"
            zone = "asia-south1-b"
            boot_size_gb = 10
        }
        db-app = {
            machine_type = "e2-small"
            zone = "us-central1-a"
            boot_size_gb = 20
        }
    
    }
}






resource "google_compute_instance" "m_vm" {
    for_each = var.more_vms      #map
    name = each.key
    machine_type = each.value.machine_type
    zone = each.value.zone



    boot_disk {
        initialize_params {
          image = "debian-cloud/debian-11"
        size = each.value.boot_size_gb
      
        }
    }
      network_interface {
    network = "default"
    access_config {}
  }

  tags = ["ssh"]
}


