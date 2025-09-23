#
variable "vm_names" {
    default = [
        raghu-app,
        raghu-dev,
        raghu-test,
        prod-env
    ]
  
}
in main.tf we call like 

name=length(var.vm_names)
count=var.vm_names[count.index]

#__________________________
3 vm in different zones in one rgion
'  count        = 3
  name         = "vm-${count.index}"            # dynamic name
  zone         = "us-central1-${["a","b","c"][count.index]}" vmo-centala,b,c


  #machine type
  variable "machine_types" {
  default = ["e2-small", "e2-medium", "e2-micro"]
}
 machine_type = var.machine_types[count.index]

 #dynamic way 
 resource "google_compute_instance" "vm" {
  count = 3
  name  = "vm-${count.index}"  

  # Dynamic machine type list inline
  machine_type = ["e2-small", "e2-medium", "e2-micro"][count.index]

  zone = "us-central1-${["a","b","c"][count.index]}"  