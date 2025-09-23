resource "google_compute_network" "vpc_project_A" {
  name                    = "project-a-net"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet_A" {
  name          = "project-a-subnet"
  ip_cidr_range = "10.1.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_project_A.id

}


#create vm
resource "google_compute_instance" "count_vm" {
  name  = "vm-${count.index}"
  zone = "us-central1-b"
  count = 2
  #write another way
  #variable "create_vm" {
  #   type = bool default =false       and number type also we write   
  #}
  #count = var.create_vm ? 1:0

  machine_type = "e2-small"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    
    access_config {

    }
  }

}




