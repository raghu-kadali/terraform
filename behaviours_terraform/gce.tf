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
  # which subnet vm create
  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {
      #default one pablic ip give used to see my data on screen(startup data)
    }
  }
  #when vm creatre run this startup script that time terraform says use find method
  # metadata_startup_script = file("pass the script path where your scrtipt")
  #path.module is a Terraform built-in variable. where your module locatede /beva/gc,pr,star
  metadata_startup_script = file("${path.module}/startup.sh")

  #incase tags you mention but change so give dynamic we use one method call tool

  # tags = ["i27-ssh-network-tag", "i27-ssh-network-tag-other","i27-webserver-network-tag"]
  # tags not hardcoded sometimes change so using tolist we write
  tags = [
    #index whatever we write same firewall it takes automatioc 
    tolist(google_compute_firewall.tf_ssh.target_tags)[1],
    tolist(google_compute_firewall.tf_ssh.target_tags)[0],
    tolist(google_compute_firewall.tf_http.target_tags)[0]
  ]
  #when any chance to stop and update that time this below lin s importand
  allow_stopping_for_update = true 
}