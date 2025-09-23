# variables
variable "project_id" {
  type    = string
  default = "terraform-project-470306"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

# Provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Create VPC
resource "google_compute_network" "my_vpc" {
  name                    = "demo-vpc2"
  auto_create_subnetworks = false
}

# Create Subnet (explicit depends_on)
resource "google_compute_subnetwork" "my_subnet" {
  name          = "demo-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       ="demo-vpc2"  #  this subnet belongs to this vpc<-- using name instead of .id

  depends_on = [
    google_compute_network.my_vpc
  ]
}

# Create VM (explicit depends_on)
resource "google_compute_instance" "my_vm" {
  name         = "demo-vm3"
  machine_type = "e2-small"
  zone         = var.zone

  depends_on = [
    google_compute_subnetwork.my_subnet
  ]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = "demo-subnet"   # < place the vm inside these subnet-- using name instead of .id
  }
  lifecycle {
    create_before_destroy = true
    #prevent_destroy = true
    ignore_changes = [
        metadata_startup_script
    ]
    # if any changes happen this meta script ignore no change ok anything not only meta nay argument
  }
  metadata_startup_script = "this is new terraform concepts learsn from last week"
}

#if you use a literal string instead of .id, you must explicitly mention depends_on to ensure Terraform creates resources in the correct or


# actual implementation
# # variables
# variable "project_id" {
#   type    = string
#   default = "your-gcp-project-id"
# }

# variable "region" {
#   type    = string
#   default = "us-central1"
# }

# variable "zone" {
#   type    = string
#   default = "us-central1-a"
# }

# # Provider
# provider "google" {
#   project = var.project_id
#   region  = var.region
# }

# # Create VPC
# resource "google_compute_network" "my_vpc" {
#   name                    = "demo-vpc"
#   auto_create_subnetworks = false
# }

# # Create Subnet
# resource "google_compute_subnetwork" "my_subnet" {
#   name          = "demo-subnet"
#   ip_cidr_range = "10.0.0.0/24"
#   region        = var.region
#   network       = google_compute_network.my_vpc.id
# }

# # Create VM - force it to wait for subnet
# resource "google_compute_instance" "my_vm" {
#   name         = "demo-vm"
#   machine_type = "e2-micro"
#   zone         = var.zone

#   # meta-argument here 👇
#   depends_on = [
#     google_compute_subnetwork.my_subnet
#   ]

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#     subnetwork = google_compute_subnetwork.my_subnet.id
#   }
# }


