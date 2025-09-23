

provider {
    project = "terraform-project-470306"
    region = "asia-south2" #delhi
}

provider "google" {
  alias   = "projectB"
  project = "terraform-project-470306"
  region  = "us-central1"
}

# as well as alias we mention only region no projects it takes default

resource "google_compute_instances" "vm_tf" {
    name = "first-vm"
    machine_type = "e2-micro"
    zone = "us-central1-c"
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


