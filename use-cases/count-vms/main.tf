
#varibles.tf
variable "project_id" {
    type = string
}
variable "region" {
    type = string
  
}
variable "machine_type" {
  type = string
}



# Provider block
provider "google" {
  project = var.project_id # replace with your GCP project ID
  region  = var.region
  
}

# Create multiple instances using count
resource "google_compute_instance" "vm" {
  count        = 3                        # number of VMs
  name         = "vm-${count.index + 1}"  # vm-1, vm-2, vm-3
  machine_type = var.machine_type
  zone         = "asia-south1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}


#WITH SUBNET AND OUTPUT

# =========================
# VARIABLES
# =========================
variable "project_id" {
  type = string

}

variable "region" {
  type = string
}

variable "zone" {
  type    = string
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "vm_count" {
  type    = number
  default = 3
}

variable "network_name" {
  type    = string
  default = "custom-vpc"
}

# =========================
# PROVIDER
# =========================
provider "google" {
  project = var.project_id
  region  = var.region
}

# =========================
# CUSTOM VPC AND SUBNET
# =========================
resource "google_compute_network" "custom_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom_subnet" {
  name          = "${var.network_name}-subnet"
  # WE WRITE VAR.SUBNET NO PROBLEM
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.custom_network.id
}

# =========================
# MULTIPLE VM INSTANCES
# =========================
resource "google_compute_instance" "vm" {
  count        = var.vm_count
  name         = "vm-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.custom_network.id
    subnetwork = google_compute_subnetwork.custom_subnet.id
    access_config {}  # assign external IP
  }
}

# =========================
# OUTPUT
# =========================
output "vm_public_ips" {
  value = [for instance in google_compute_instance.vm : instance.network_interface[0].access_config[0].nat_ip]
}
