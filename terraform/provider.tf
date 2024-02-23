
provider "google" {
  project = var.project_id
  region = var.region
}

# provider "google-beta" {
#   project = var.project_id
#   region = var.region

# }

# terraform {
#   backend "gcs" {
#     bucket = "rick-and-nardy-tfstate"
#     prefix  = "terraform/state"
#   }
# }

