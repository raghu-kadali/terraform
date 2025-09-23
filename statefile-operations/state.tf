terraform {
  required_providers {
    google = {
      source = "hashicorp/google" 
      version = "~> 5.0"
    }
  }
}
provider "google" {
  project = "terraform-project-470306"
  region = "us-central1"
  zone = "us-central1-c"
  
}



#vpc creation:
# Example 1: Create VPC (basic infrastructure creation)
resource "google_compute_network" "tf_vpc" {
  name                    = "i27-vpc-1"
  auto_create_subnetworks = false
  description             = "Creating a VPC from terraform"
}

# Create Subnet
resource "google_compute_subnetwork" "tf_subnet" {
  name          = "i27-subnet"
  region        = "us-central1"
  ip_cidr_range = "10.6.0.0/16"
  network       = google_compute_network.tf_vpc.id
}

# Create SSH Firewall Rule
resource "google_compute_firewall" "tf_ssh" {
  name          = "i27-allow-ssh-22"
  network       = google_compute_network.tf_vpc.id
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }


}

resource "google_compute_instance" "vm" {
  name         = "state-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    # Optional: to get public IP, add access_config {}
    # access_config {}
  }

  tags = ["ssh"]
}

output "vm_name" {
  value = google_compute_instance.vm.name
}
output "vpc_name" {
  value = google_compute_network.tf_vpc.name
  
}
output "firewall_name" {
  value = google_compute_firewall.tf_ssh.name
}

