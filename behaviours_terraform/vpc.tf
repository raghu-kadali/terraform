#vpc creation:
# Example 1: Create VPC (basic infrastructure creation)
resource "google_compute_network" "tf_vpc" {
  name                    = "i27-vpc-1"
  auto_create_subnetworks = false
  description             = "Creating a VPC from terraform"
}

# Create Subnet
resource "google_compute_subnetwork" "tf_subnet" {
  name          = "i27-subnet"
  region        = "us-central1"
  ip_cidr_range = "10.6.0.0/16"
  network       = google_compute_network.tf_vpc.id
}

# Create SSH Firewall Rule
resource "google_compute_firewall" "tf_ssh" {
  name          = "i27-allow-ssh-22"
  network       = google_compute_network.tf_vpc.id
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  #When traffic comes to a VM’s IP → firewall first checks port → if port matches → then checks VM’s tag → if VM has that tag → it allows traffic.
  #VM Operating System (OS) takes over

  # The OS receives the packet on its network interface card (NIC).

  # OS knows:

  # The protocol (TCP/UDP).

  # The destination port (e.g., 80, 22, 443).

  # The source IP (who sent it).

  # The destination IP (the VM’s IP).

  # 👉 OS has all this info automatically — it’s built into how networking works.
  #later vm have every application then check if run ok other wise reject

  target_tags = ["i27-ssh-network-tag", "i27-ssh-network-tag-other"]
}

# Create HTTP Firewall Rule
resource "google_compute_firewall" "tf_http" {
  name          = "fwrule-allow-http80"
  network       = google_compute_network.tf_vpc.id
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["i27-webserver-network-tag"]
}

