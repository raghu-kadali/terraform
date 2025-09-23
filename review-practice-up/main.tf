# provider "google" {
#   project = "terraform-project-470306"  # Added closing quote
#   region  = "asia-south1"
#   zone    = "asia-south1-c"
# }

# resource "google_compute_instance" "web_vm" {
#   name         = "webserver-vm"
#   machine_type = "e2-medium"
#   zone         = "asia-south1-c"

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-os-cloud/ubuntu"
#     }
#   }

#   network_interface {
#     network = "default"

#     access_config {
#       # external IP
#     }
#   }
    
#   # Read script from file
#   metadata_startup_script = file("${path.module}/startup.sh")

#   tags = ["http-server"]
# }

# resource "google_compute_firewall" "default-allow-http" {
#   name    = "allow-http"
#   network = "default"

#   allow {
#     protocol = "tcp"
#     ports    = ["80"]
#   }

#   target_tags = ["http-server"]
#   source_ranges = [ "0.0.0.0/0" ]
# }


provider "google" {
  project = "terraform-project-470306"  # Added closing quote
  region  = "asia-south1"
  zone    = "asia-south1-c"
}




# 1. Create a custom VPC
resource "google_compute_network" "custom_vpc" {
  name                    = "my-custom-vpc"
  auto_create_subnetworks = false   # we will create our own subnet
}

# 2. Create a subnet inside custom VPC
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "my-custom-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "asia-south1"
  network       = google_compute_network.custom_vpc.id
}

# 3. Firewall rule (allow SSH + HTTP)
resource "google_compute_firewall" "allow-http-ssh" {
  name    = "allow-http-ssh"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  target_tags = ["web-vm"]
  source_ranges = [ "0.0.0.0/0" ]
}

# 4. VM attached to custom VPC
resource "google_compute_instance" "web_vm" {
  name         = "custom-vpc-vm"
  machine_type = "e2-medium"
  zone         = "asia-south1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.custom_vpc.id
    subnetwork = google_compute_subnetwork.custom_subnet.id

    access_config {}  # gives external IP
  }

  tags = ["web-vm"]
  

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl start apache2
    echo "<h1>Hello from VM in custom VPC 🚀</h1>" > /var/www/html/index.html
  EOT
}












