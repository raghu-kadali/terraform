resource "google_compute_network" "vpc1" {
  name                    = "bombard-net"
  auto_create_subnetworks = false
}

variable "subnets" {
  description = "Trying to create multiple subnets"
  type = map(object({
    region     = string
    cidr_block = string
  }))
  default = {
    us-central1 = {
      region     = "us-central1"
      cidr_block = "10.1.0.0/24"
    }
    us-east1 = {
      region     = "us-east1"
      cidr_block = "10.3.0.0/24"
    }
  }
}

resource "google_compute_subnetwork" "subnet" {
  for_each      = var.subnets
  name          = "soft-subnet-${each.key}"
  region        = each.value.region
  ip_cidr_range = each.value.cidr_block
  network       = google_compute_network.vpc1.id
}
