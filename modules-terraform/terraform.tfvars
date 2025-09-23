#varible type you define but that varibles values we define we use .tfvardc precendece respect to varible
projectid = "terraform-project-470306"
vpc_name  = "module-vpc1"

#subnet
subnet_name   = "module-subnet"
ip_cidr_range = "10.0.3.0/24"
region        = "us-central1"

vm_name      = "module-vm"
zone         = "us-central1-c"
machine_type = "e2-micro"
image        = "debian-cloud/debian-12"
