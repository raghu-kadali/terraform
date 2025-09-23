#every resource we craete first need to be the which cloud we connect and create 
#present we are using google right lets start


provider "google" {
    project = "terraform-project-470306"
    region = "asia-south2" #delhi
}

provider "google" {
  alias   = "projectB"
  project = "terraform-project-470306"
  region  = "us-central1"
}

variable "vm_zone" {
    type = string
    default = "us-central1-c"
}

#

resource "google_compute_network" "tf_vpc" {
    name = "first-vpc-default"
    auto_create_subnetworks = false
}
# as well as alias we mention only region no projects it takes default

resource "google_compute_instance" "vm_tf" {
    name = "first-vm"
    machine_type = "e2-micro"
    zone = var.vm_zone
    provider = google.projectB
    boot_disk {
        initialize_params { # id define image(os,debian,ubun),disktype,disksize
            image = "debian-cloud/debian-11" # it means disktype pd standard default,size 10gb default
        }

    }
    network_interface {
        network = "default"
        access_config {}  #public ip
    }
}

data "google_compute_instance" "bombard_vm" {
  name = "bombard"
  zone = "southamerica-east1-a"  # The zone where your VM exists
}


#bucket creation 
# Bucket creation its like a folder
# resource "google_storage_bucket" "new_bucket" {
#   name          = "indian-data"
#   location      = "us-central1"
#   force_destroy = true
# }

#bucket object: store the file inside bucket like files 


#create sql database but before create data we create cloud sql instance without instance we cannot 
# resource "google_sql_database_instance" "my_instance" {
#     name = "first-sql-instance"
#     region = "asia-south1"
#     database_version = "MYSQL_8_0" 
#     settings {
#     tier = "db-f1-micro"   # small machine like machine_e2-micro small like 
#   }
# }

# #Now create database inside the sql instance

# resource "google_sql_database" "my_database" {
#     name = "first-database"
#     instance = google_sql_database_instance.my_instance.name
  
# }







#vm creatuipn with static ip
resource "google_compute_address" "static_ip" {
  name   = "first-vm-static-ip"
  region = "us-central1"   # use the same region as your VM zone
}
resource "google_compute_instance" "vm_tf" {
  name         = "first-vm"
  machine_type = "e2-micro"
  zone         = var.vm_zone
  provider     = google.projectB

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    # Attach reserved static IP
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }
}

# Output the VM's internal (private) IP
output "vm_internal_ip" {
  value = google_compute_instance.vm_tf.network_interface[0].network_ip
  description = "The internal/private IP of the VM"
}

# Output the VM's external (static) IP
output "vm_external_ip" {
  value = google_compute_instance.vm_tf.network_interface[0].access_config[0].nat_ip
  description = "The external/static IP of the VM"
}

              


# 1️⃣ network_interface[0]

# A VM can have multiple NICs (Network Interface Cards).

# [0] means the first network interface of the VM.

# This NIC is what connects the VM to a network (VPC/subnet).

# Think: network_interface[0] = the VM’s first “network adapter.”

# 2️⃣ access_config[0]

# Each NIC can have access_config → configuration for public/external IP.

# [0] means the first public IP configuration for that NIC.

# Inside this, you can get the external IP (nat_ip).

# Think: access_config[0] = “how this NIC gets its public IP.”





Your VM has a private IP (inside VPC) → not reachable from the internet.

NAT takes that private IP and translates it to a public IP so traffic can flow in and out.



NAT assigns a public IP to the private IP for outbound/inbound traffic
nat = it provide public/static ip : public is ephermal and statsic is fixed
internel and external is same 