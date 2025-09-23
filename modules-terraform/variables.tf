variable "projectid" {
  type = string
}

variable "vpc_name" {
  type = string

}

#subnet
variable "subnet_name" {
  type = string
}
variable "ip_cidr_range" {
  type = string
}
variable "region" {
  type = string
}


#gce

variable "vm_name" {
  type = string
}
variable "zone" {
  type = string
}

variable "machine_type" {
  type = string

}
variable "image" {
  type = string

}
