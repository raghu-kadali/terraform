resource "google_compute_subnetwork" "subnet" {
    name = var.subnet_name
    ip_cidr_range = var.ip_cidr_range
    network = var.vpc_id
    region = var.region
  
}