#create vpc
resource "google_compute_network" "intern-ecommerce-vpc" {
    name = var.vpc_name
    auto_create_subnetworks = false
    
}

#create multiple subnets based upon customer choice only
resource "google_compute_subnetwork" "intern-ecommerce-subnet" {
    count = length(var.subnets) #how many we want lopop repeat that lenght function
    name = var.subnets[count.index].name
    ip_cidr_range = var.subnets[count.index].ip_cidr_range
    region = var.subnets[count.index].subnet_region
    network = google_compute_network.intern-ecommerce-vpc.id #selflink also recommended
    #all above repeat loops
}

# create firewall

resource "google_compute_firewall" "intern-ecommerce-subnet" {
    name = var.firewall_name
    network = google_compute_network.intern-ecommerce-vpc.id 
    direction = "INGRESS"
    priority = 1000
    source_ranges = var.source_ranges   #pluralranges
    allow {
      protocol = "tcp"
      ports = ["22", "80","8080","9000"]
    }
  
}


