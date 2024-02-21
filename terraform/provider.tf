
provider "google" {
  project = var.project_id
  region = var.region
}

# provider "google-beta" {
#   project = var.project_id
# }

# backend "gcs" {
#   bucket = "rick-and-nardy-tfstate"
# }

terraform {
  backend "gcs" {
    #bucket  = "tf-state-prod"
    bucket = "rick-and-nardy-tfstate"
    prefix  = "terraform/state"
  }
}

# resource "google_compute_instance" "default" {
#   name         = "my-instance"
#   machine_type = "n1-standard-1"
#   zone         = "us-central1-a"
# }
