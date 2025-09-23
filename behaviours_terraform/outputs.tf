output "vpc-id" {
    value = google_compute_network.tf_vpc.id
}
output "subnet-id" {
  value = google_compute_subnetwork.tf_subnet.id
}
output "vm_external-ip" {
    value = google_compute_instance.tf_gce_vm.network_interface[0].access_config[0].nat_ip
  
}