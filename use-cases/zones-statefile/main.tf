# 

#  #. I need to configure the two VMs in different zones with a single codebase, and I need separate state
# files? ---workspace
provider "google" {
  project = "terraform-project-470306"
  region  = "us-central1"
}

resource "google_compute_instance" "vm" {
  name         = "vm"          # Same name in code
  machine_type = "e2-medium"
  zone         = "us-central1-a" # This will differ per workspace
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network       = "default"
    access_config {}
  }
}