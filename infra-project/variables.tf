variable "projectid" {
    type = string  
}
variable "region" {
    type = string
  
}
variable "vpc_name" {
  type = string
}
variable "subnets" {
    type = list(object({
      name = string
      ip_cidr_range = string
      subnet_region = string
    }))
}

variable "firewall_name" {
    type = string
}
variable "source_ranges" {
  type = list(string)
}

variable "instances" {
    type = map(object({
    machine_type = string
    zone = string
    disk_size = number
    subnet = string
  }))
}
variable "vm_user" {
  type = string
  
}