# single object_____creates only one vm

variable "vm" {
  type = object({
    name         = string
    machine_type = string
    zone         = string
  })
}
# .tfvars
vm = {
  name         = "vm1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
}

# incode:
resource "google_compute_instance" "vm" {
    name = var.vm.name
    machinetype=var.vm.machinetyoe
    zone = var.vm.zone
}

# list of object______muttiple vm no for each argumrnt 

variable "vm_list" {
  type = list(object({
    name         = string
    machine_type = string
    zone         = string
  }))
}
# tfvars
vm_list = [
  { name = "vm1", machine_type = "e2-medium", zone = "us-central1-a" },
  { name = "vm2", machine_type = "e2-small",  zone = "us-central1-b" }
]
# incode
# First VM (index 0)
resource "google_compute_instance" "first_vm" {
  name         = var.vm_list[0].name
  machine_type = var.vm_list[0].machine_type
  zone         = var.vm_list[0].zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }
}

# Second VM (index 1)
resource "google_compute_instance" "second_vm" {
  name         = var.vm_list[1].name
  machine_type = var.vm_list[1].machine_type
  zone         = var.vm_list[1].zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }
}
var.vm_list[1]

___________________________________________________________



# important for_each
only main.tf change

variable "vm_map" {
  type = map(object({
    machine_type = string
    zone         = string
  }))
}
#tfvars
vm_map = {
  vm1 = { machine_type = "e2-medium", zone = "us-central1-a" }
  vm2 = { machine_type = "e2-small",  zone = "us-central1-b" }
}

# incode
resource "google_compute_instance" "vms" {
  for_each = var.vm_map

  name         = each.key                         # vm1, vm2
  machine_type = each.value.machine_type          # e2-medium, e2-small
  zone         = each.value.zone                  # us-central1-a, us-central1-b

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }
}
