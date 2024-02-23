# Read only object (resource)
data "google_project" "my_project" {
      project_id = var.project_id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/billing_account#billing_account
data "google_billing_account" "my_baid" {
      billing_account = data.google_project.my_project.billing_account
#  display_name = "My Billing Account"
#  open         = true
}


locals {
      project_number = data.google_project.my_project.number
      baid_name =  data.google_billing_account.my_baid.display_name
}

output "baid_name" {
      value = local.baid_name
}

output "project_number" {
      value = local.project_number
}

# terraform state list
# terraform state show
# terraform state show data.google_project.project
# # data.google_project.project:
# data "google_project" "project" {
#     billing_account  = "..."
#     effective_labels = {}
#     folder_id        = "1053275019153"
#     id               = "projects/rick-and-nardy-demo"
#     labels           = {}
#     name             = "Rick and Nardy - Demo"
#     number           = "849075740253"
#     project_id       = "rick-and-nardy-demo"
#     terraform_labels = {}
# }
