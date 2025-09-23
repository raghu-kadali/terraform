provider "google" {
    project = "terraform-project-470306"
    region = "us-central1"
}


#CREATE A BUCKET

resource "google_storage_bucket" "first_bucket" {
    name = "terraform-project-470306-bucket"
    location = "US"
}

#upload local file

resource "google_storage_bucket_object" "onefile" {
    name = "raghu.txt"
    bucket = google_storage_bucket.first_bucket.name
    source = "raghu.txt"
}

#make object or is a public
resource "google_storage_bucket_iam_member" "allusers" {
    bucket = google_storage_bucket.first_bucket.name
    role = "roles/storage.objectViewer"
    member = "allUsers"

  
}

# particular person 
# resource "google_storage_bucket_iam_member" "bombard-rakesh" {
#   bucket = google_storage_bucket.my_bucket.name
#   role   = "roles/storage.objectViewer"
#   member = "serviceAccount:my-sa@my-project.iam.gserviceaccount.com"
# }



# store statefile in backend

# terraform {
#   backend "gcs" {
#     bucket      = "my-terraform-state"
#     prefix      = "terraform/state"
#     credentials = "service-account.json"
#   }
# }

# provider "google" {
#   project = "my-gcp-project-id"
#   region  = "us-central1"
# }

# resource "google_compute_instance" "my_vm" {
#   name = "existing-vm"
#   zone = "us-central1-a"
# }

