provider "google" {
    project = "terraform-project-470306"
    region = "us-central1"
  
}
# variable "region" {
#     type = string
#     default = "us-central1"
# }


locals {
    region = "asia-south1"
}

output "local_region" {
  value = local.region
}
# output "variable_region" {
#     value = var.region
  
# }

# second scenario: local+expressions
 # one sinlge change all changes 
# Avoid repetaetion: same value used multiple times in module
variable "env" {
  default = "dev"
}

variable "project" {
  default = "payments"
}

locals {
  base_name = "${var.env}-${var.project}"
}

resource "google_compute_instance" "vm" {
  name         = "${local.base_name}-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"   # ✅ boot disk image
      size  = 10                         # ✅ disk size in GB
      type  = "pd-balanced"              # ✅ disk type (standard, ssd, balanced)
    }
  }

  network_interface {
    network = "default"
    access_config {}   # enables external IP
  }
}

resource "google_storage_bucket" "bucket" {
  name     = "${local.base_name}-bucket"
  location = "US"
}
# output: dev-payments-vm and dev-poayments-bucket
