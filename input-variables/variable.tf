variable "project_id1" {
    description = "this is the projcet id"
    type = string
    default = "terraform-project-470306"
}

variable "region" {
    type = string
    default = "us-central1"
}

variable "machine_type" {
    type = string
    default = "e2-medium"
}

variable "zone_name" {
  type = string
  default = "us-central1-b"
}

variable "vm_name" {
    type = string
    default = "varible-vm"
  
}