#Automatically create a Linux VM on GCP, install Apache web server, copy a configuration file (app.conf) into it, and confirm successful creation
# output: systemctl status apache2
#         ls -l cat app.conf


provider "google" {
  project = "terraform-project-470306"
  region  = "us-central1"
}

resource "google_compute_instance" "vm_tf" {
  name         = "f-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}  # Ephemeral public IP will be auto-assigned
  }

  # "Create a Linux user called raghu inside the VM and add this public key to his authorized_keys file.
  metadata = {
    ssh-keys = "raghu:${file("~/.ssh/id_ed25519.pub")}"
  }

  # 1️⃣ Remote-exec provisioner: install Apache
  provisioner "remote-exec" {
    inline = [ #list of shell commands exceute inside vm
      "sudo apt-get update",
      "sudo apt-get install -y apache2"
    ]
##This tells Terraform how to connect to your VM using SSH.
    connection {
      type        = "ssh"
      host        = google_compute_instance.vm_tf.network_interface[0].access_config[0].nat_ip
      user        = "raghu"
      private_key = file("~/.ssh/id_ed25519")
    }
  }

  # 2️⃣ File provisioner: copy app.conf to /home/raghu first
  provisioner "file" { 
    source      = "C:/Users/vara/app.conf"
    destination = "/home/raghu/app.conf"

    connection {
      type        = "ssh"
      host        = self.network_interface[0].access_config[0].nat_ip
      user        = "raghu"
      private_key = file("~/.ssh/id_ed25519")
    }
  }

  # 3️⃣ Local-exec provisioner: print confirmation
  provisioner "local-exec" {
    command = "echo VM ${self.name} created successfully"
  }
}


#ssh=talk to local machne to your vm 


 # Move file to /etc/app.conf using sudo

  #if you want root otehrwise not get in 
#But raghu cannot directly copy into /etc because only the root user has permission there.
#   provisioner "remote-exec" {
#     inline = [  #list 
#       "sudo mv /home/raghu/app.conf /etc/app.conf",
#       "sudo chown root:root /etc/app.conf"
#     ]
#     connection {
#       type        = "ssh"
#       host        = self.network_interface[0].access_config[0].nat_ip
#       user        = "raghu"
#       private_key = file("~/.ssh/id_ed25519")
#     }
#   }




















# provider "google" {
#   project = "terraform-project-470306"
#   region  = "us-central1"  # fixed typo
# }

# # Reserve a static IP
# resource "google_compute_address" "static_ip" {
#   name   = "my-static-ip"
#   region = "us-central1"
# }

# resource "google_compute_instance" "vm_tf" {
#   name         = "f-vm"
#   machine_type = "e2-micro"
#   zone         = "us-central1-c"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#     network = "default"
#     access_config {
#       nat_ip = google_compute_address.static_ip.address
#     }
#   }

#   # Add your public key to create Linux user 'raghu'
#   metadata = {
#     ssh-keys = "raghu:${file("~/.ssh/id_ed25519.pub")}"
#   }

#   # 1️⃣ Remote-exec provisioner: install Apache
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update",
#       "sudo apt-get install -y apache2"
#     ]

#     connection {
#       type        = "ssh"
#       host        = self.network_interface[0].access_config[0].nat_ip
#       user        = "raghu"                     # Linux user
#       private_key = file("~/.ssh/id_ed25519")   # Private key path
#     }
#   }

#   # 2️⃣ File provisioner: copy app.conf to /home/raghu first
# provisioner "file" {
#   source      = "C:/Users/vara/app.conf"
#   destination = "/home/raghu/app.conf"

#   connection {
#     type        = "ssh"
#     host        = self.network_interface[0].access_config[0].nat_ip
#     user        = "raghu"
#     private_key = file("~/.ssh/id_ed25519")
#   }
# }
#   # Move file to /etc/app.conf using sudo
#   provisioner "remote-exec" {
#     inline = [
#       "sudo mv /home/raghu/app.conf /etc/app.conf",
#       "sudo chown root:root /etc/app.conf"
#     ]
#     connection {
#       type        = "ssh"
#       host        = self.network_interface[0].access_config[0].nat_ip
#       user        = "raghu"
#       private_key = file("~/.ssh/id_ed25519")
#     }
#   }

#   # 3️⃣ Local-exec provisioner: print confirmation
#   provisioner "local-exec" {
#     command = "echo VM ${self.name} created successfully"
#   }
# }


# # login vm check ls -l/ under cat /etc/app.conf----data avaible 

# #this isa ctullt create gitbash echo "This is a sample app configuration" > app.conf
# # path is here C:/Users/vara/app.conf"

