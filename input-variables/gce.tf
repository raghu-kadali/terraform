
resource "google_compute_instance" "example_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone_name

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}