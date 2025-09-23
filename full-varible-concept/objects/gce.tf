resource "google_compute_instance" "tf_gce_vm" {
  #multiple argfuments
  name         = "i27-webserver"
  zone         = "us-central1-c"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      #image
      image = "debian-cloud/debian-12"
    }
  }
  
  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {
    
    }
  }

  metadata_startup_script = file("${path.module}/startup.sh")


  tags = [

    tolist(google_compute_firewall.tf_ssh.target_tags)[1],
    tolist(google_compute_firewall.tf_ssh.target_tags)[0],
    tolist(google_compute_firewall.tf_http.target_tags)[0]
  ]
  
  allow_stopping_for_update = true 
}