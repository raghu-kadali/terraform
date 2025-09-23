provider "google" {
    project = var.projectid
    region = var.region
}

variable "db_name" {
    type = string
    default = "mysql-database"
}
variable "db_user" {
    type = string
    default = "raghu"
  
}

variable "db_password" {
    description = "databse user password"
    type = string
    sensitive = true #if any action like plan apply etc hidden incase this password if you want to see go dtatefile at execution hidden
                     # incase use =false when plan it show your [password]   
}

# but when you call the best way -var(terraform apply -var="db_password=secure")  and other scenario enter value no other methods till today in jevkins change use credintials


#They are differnet in varipus name
# database---originize colection of data
#database instancc:A database instance is a single running database engine (software + memory + processes) that manages one or more databases.
#mysql database: school_db,teacher_db,boooks-db etc
resource "google_sql_database_instance" "sql_database_instance" {
    name = var.db_name
    database_version = "MYSQL_8_0"
    region = var.region
    #EVERY db INSTANCE SOME mandatoty CONFIGRATIONS SO THAT DEFINE IN SETTINGS BLOCK
    settings {
        tier = "db-f1-micro"
        ip_configuration {
          ipv4_enabled = true
          authorized_networks {
            name = "allow-public-ip"
            value = "0.0.0.0/0"
          }
        }
    }
    deletion_protection = false #delete if you delete incase true not deleted
}
#inside databse create user
#.name:db instance name
resource "google_sql_user" "db_user" {
    instance = google_sql_database_instance.sql_database_instance.name 
    name = var.db_user
    password = var.db_password
 
}