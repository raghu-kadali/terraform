provider "google" {
  project = var.project_id
  region  = var.region
}



resource "google_compute_network" "tf_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "tf_subnet" {
  name          = var.subnet_name
  region        = var.region
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.tf_vpc.id
}
resource "google_compute_firewall" "tf_ssh" {
  name = "firewall-ssh"
  network = google_compute_network.tf_vpc.id
  direction = "INGRESS"
  allow {
    ports = [var.ssh_port]
    protocol = "tcp"
  }
  priority = var.ssh_priority
   source_ranges=["0.0.0.0/0"]
   target_tags = ["ssh-tag"]
  
}

#other firewal
resource "google_compute_firewall" "tf_http"{
  name = "firewall-http"
  network = google_compute_network.tf_vpc.id
  direction = "INGRESS"
  allow {
    ports = [var.http_port]
    protocol = "tcp"
  }
  priority = var.hht_priority
   source_ranges= ["0.0.0.0/0" ]
   target_tags = ["http-tag"]
  
}
# resource "google_compute_instance" "tf_gce_vm" {
#   name         = var.vm_config.name
#   #map(string)
#   machine_type = var.vm_config.machine_type
#   zone         = var.vm_config.zone

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-12"
#     }
#   }

#   network_interface {
#     subnetwork = google_compute_subnetwork.tf_subnet.id
#     access_config {}
#   }

#   #metadata_startup_script = file("${path.module}/startup.sh")
#   # : means this or(:) this    nul dont do that incase false
#   metadata = {
#     startup_script = file("${path.module}/startup.sh")
#   }
  
#     tags = var.vm_config.tags

# }
 resource "google_compute_instance" "vm" {
  name = var.vm_list[0].name
  machine_type = var.vm_list[0].machine_type
  zone = var.vm_list[0].zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {}
  }

  #metadata_startup_script = file("${path.module}/startup.sh")
  # : means this or(:) this    nul dont do that incase false
  metadata = {
    startup_script = file("${path.module}/startup.sh")
  }
  
    #tags = var.vm_config.tags
    tags = var.vm_list[0].tags
 }
#vm2
resource "google_compute_instance" "vm1" {
  name = var.vm_list[1].name
  machine_type = var.vm_list[1].machine_type
  zone = var.vm_list[1].zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {}
  }

  #metadata_startup_script = file("${path.module}/startup.sh")
  # : means this or(:) this    nul dont do that incase false
  metadata = {
    startup_script = file("${path.module}/startup.sh")
  }
  
    #tags = var.vm_config.tags
    tags = var.vm_list[1].tags
 }


