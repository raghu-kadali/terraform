variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type    = string
  default = "us-central1"
}

# variable "zone" {
#   type    = string
#   default = "us-central1-a"
# }

variable "vpc_name" {
  type    = string
  default = "i27-vpc"
}

variable "subnet_name" {
  type    = string
  default = "i27-subnet"
}

variable "subnet_cidr" {
  type    = string
  default = "10.6.0.0/16"
}

#variable "vm_name" {
 # type    = string
  #default = "i27-webserver"
#}

  # variable "machine_type" {
  #   type    = string
  #   default = "e2-micro"
  # }

variable "ssh_priority" {
  type = number
  default = 500
}
variable "hht_priority" {
  type = number
  default = 1000
}
variable "ssh_port" {
  type = number
  default = 22
  
}

variable "http_port" {
  type = number
  default = 80

  
}
# #BOOLEAN
# variable "enable_start_script" {
#   type = bool
#   default = false
  
# }
# #list of strings
# # variable "vm_tags" {
# #   type = list(string)
# #   default = [ "i27-ssh-network-tag", "i27-webserver-network-tag" ]  
# # }

# #map(string)--collection of key-value pairs used majorly environments (dev.prod,test) differnt configs(vm,disk size)
 variable "environment_areas" {
  type    = string
  default = "test"
 }

# variable "machine_types1" {
#   type = map(string)
#   default = {
#     dev  = "e2-micro"
#     test = "e2-small"
#     prod = "e2-medium"
#   }
# }
# # objects
# variable "vm_config" {
#   type = object({
#     name = string
#     machine_type = string
#     zone = string
#     tags = list(string)
#   })
#   default = {
#     name = "best-vm"
#     machine_type = "e2-micro"
#     zone = "us-central1-c"
#     tags = [ "vm1tag","vm2tag" ]
#   }
# }



#list of objects
  

variable "vm_list" {
  type = list(object({
    name = string
    machine_type = string
    zone = string
    tags = list(any)
  }))

  
}