provider "google" {
  project = "terraform-project-470306"
  region  = "us-central1"
}

variable "instances_names" {
    description = "list of gce instances names"
    type = list(string)
    default = [ "first-instance","second-instance" ]
  
}
#create vm
resource "google_compute_instance" "count_vm" {
    for_each = toset(var.instances_names)
  name  = each.key
  zone = "us-central1-b"
  machine_type = "e2-small"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    subnetwork    = google_compute_subnetwork.subnet["us-central1"].id
    access_config {

    }
  }

}