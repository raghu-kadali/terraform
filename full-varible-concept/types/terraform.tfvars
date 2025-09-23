project_id     = "terraform-project-470306"
# region         = "us-central1"
# zone           = "us-central1-a"
# vm_name        = "custom-vm-name"
# machine_type   = "e2-medium"
# ssh_port = 89
# vm_tags = [ "i27-ssh-network-tag", "i27-webserver-network-tag","raghu-learning-tag"]

vm_list = [
  {
    name         = "raghu-vm"
    machine_type = "e2-micro"
    zone         = "us-central1-a"
    tags         = ["efrf", "yku"]
  },
  {
    name         = "raghu-vm1"
    machine_type = "e2-small"
    zone         = "us-central1-c"
    tags         = ["eferf", "ykue"]
  }
]