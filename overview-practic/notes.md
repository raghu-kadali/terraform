cloud specific: partivular one cloud
cloud agnostic: multiple cloud not binded one
terraform core: hcl-engine not interact cloud
       hcl-engine Parser = Understand code.
                 Planner = Decide actions.
provider major role:crud operations


by gcloud command authenticate 

details save :
~/.config/gcloud/application_default_credentials.json


terraform init-terraform core knows
                         -registry.terraform.io-  after
                         (google path)registry.terraform.io/hashicorp/google



# variables: 


# default(d/c):majorly used no explicity give
used for poc and sandbox like dev
disadvantage: default vpc -hacker
              default ,macine type = cost effective
# prompt way(d):no default give cli ask you
used sensitive information projectid,credentials, database passwordetc this is one or two times ok but not more because below
disadvantages:
automated pipelines not used
himan sometimes give corret or not infra breaks
human enter slowable

# .tfvars(c): separe from terraform only inputs not logic like vpc,subnet and not resource 
mainly environemnt consistent
wherever you have place path 
Works with CI/CD pipelines by passing -var-file.
.tfvars only tells Terraform what values to use when creating resources.
Think of .tfvars as “ingredient list”, while .tf is the “recipe”.
i wriet sepeartley each time dev test when run time i pass
disdavnatges :
to many files so name give perfectly
name chane environment change 

# -var(c)--
# env(c): ci/cd but in prompt not gd ci/cd
$env:TF_VAR_<variable_name> = "<value>"




output block : used to show the important information after apply:
state file: its a hardcode it contains passwords everything messy dont go and check 
scenario: 
team sharing: iam creat vm our team mate wants to connect vm 
integration :if two modules one module vpc+subnet 
             Another module create vm that depends on subnet id

output "vpc_name" {

value = google_compute_network.my_vm.name

}

output "self_link" {
    value = google_compute_instance.vm1.self_link
}

output "instance_details" { #using map
  description = "A map of details for the GCE instance"
  value = {
    name         = google_compute_instance.tf_gce_vm.name
    machine_type = google_compute_instance.tf_gce_vm.machine_type
    zone         = google_compute_instance.tf_gce_vm.zone
    external_ip  = google_compute_instance.tf_gce_vm.network_interface[0].access_config[0].nat_ip
  }
}


local: cannot override any where like -var etc
