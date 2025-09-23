provider "google" {
    project = var.project_id
    region = var.region
}



resource google_compute_instance "vm" {
    count = 2
    name = "vm-${count.index}"
    #incase start particular number use vm-${count.index + 1}
    machine_type = var.machine_type
    zone = "asia-south1-c"


boot_disk {
    initialize_params {
        image = "debian-cloud/debian-11"
    }
}

network_interface {
    network = default
    access_config {

    }
}
}