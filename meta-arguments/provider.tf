#default provider
provider "google" {
  project = "terraform-project-470306"
  region  = "us-central1"
}



























# #Another provider for other project
# provider "google" {
#   alias   = "project_B"
#   project = "verdant-sensor-467205-s6"
#   region  = "asia-south1"
# }

# #______________________________project A _____________________________________________________
# resource "google_compute_network" "vpc_project_A" {
#   name                    = "project-a-net"
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "vpc_subnet_A" {
#   name          = "project-a-subnet"
#   ip_cidr_range = "10.1.0.0/16"
#   region        = "us-central1"
#   network       = google_compute_network.vpc_project_A.id

# }


# #_________________________________________project B______________________________________________

# resource "google_compute_network" "vpc_project_B" {
#   name                    = "project-b-net"
#   auto_create_subnetworks = false

#   #meta argument
#   provider = google.project_B
# }


# resource "google_compute_subnetwork" "vpc_subnet_B" {
#   name          = "project-b-subnet"
#   ip_cidr_range = "10.3.0.0/16"
#   region        = "europe-west1"
#   network       = google_compute_network.vpc_project_B.id
#   #meta
#   provider = google.project_B
# }