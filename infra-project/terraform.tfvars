projectid = "terraform-project-470306"
region = "us-central1"
vpc_name = "intern-vpc"
firewall_name = "first-firewall"
source_ranges = [ "0.0.0.0/0" ] #also mention number of ranges so give list at varible

subnets = [
    {
    name = "intern-first-subnet"
    ip_cidr_range = "10.1.0.0/16"
    subnet_region = "us-central1"
    },
    {
    name = "intern-second-subnet"
    ip_cidr_range = "10.2.0.0/16"
    subnet_region = "asia-south2"
    }
]

instances = {
    "ansible" = {
        machine_type = "e2-medium"
        zone = "us-central1-c"
        disk_size = 10
        subnet = "intern-first-subnet"
    },
    "jenkins-master" = {
        machine_type = "e2-medium"
        zone = "us-central1-c"
        disk_size = 10
        subnet = "intern-second-subnet"
    }
}
vm_user = "kadalim27"




   
