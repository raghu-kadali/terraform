provider "google" {
  project = "kubernetes-477004"
  region  = "us-central1"
}

resource "google_compute_instance" "web_vm" {
  name         = "web-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {}   # gives public IP
  }

  # SSH public key (read from file)
  metadata = {
    ssh-keys = "ubuntu:${file("web_vm_key.pub")}"
  }

  # Label used by Ansible dynamic inventory
  labels = {
    role = "web"
  }
}
