resource "google_compute_network" "tf_vpc" {
  name = "vpc1"
  
  auto_create_subnetworks = true
  description="creating vpc first time using terraform"
}


# #crete subnetwork
# #what we want:
# #gcloud compute networks subnet subnet create subnetname
# #region range networkname

# resource "google_compute_subnetwork" "tf_subnet" {
#   name = "subnet1"
#   #syntax:resourcetype.locl.attribute
#   network= google_compute_network.tf_vpc.id
#   # id=actually convert to name
#   region = "us-central1"
#   ip_cidr_range = "10.8.0.0/16"

# }
  
# #create firewall 
# #name,network,port,direction(ingress/egress),source,tags
# #PRority 0 = most powerful = first rule to respond.
# # Tags are like labels to filter which VMs the firewall rule should apply because one vpc mutiple vm are there if you give vpc level that applicable one thing what about otehr vm
# resource "google_compute_firewall" "tf_ssh1" {
#   name = "firewall-ssh"
#   network = google_compute_network.tf_vpc.id
#   direction = "INGRESS"
#   allow {
#     ports = ["22"]
#     protocol = "tcp"
#   }
#   priority = 1000
#    source_ranges=["0.0.0.0/0"]
#    target_tags = ["ssh-tag"]
  
# }

# #other firewal
# resource "google_compute_firewall" "tf_http7"{
#   name = "firewall-http3"
#   network = google_compute_network.tf_vpc.id
#   direction = "INGRESS"
#   allow {
#     ports = ["8080"]
#     protocol = "tcp"
#   }
#   priority = 500
#    source_ranges= ["0.0.0.0/0" ]
#    target_tags = ["http-tag"]
  
# }

