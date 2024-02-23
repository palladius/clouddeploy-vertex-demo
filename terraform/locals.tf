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
#compute_service_account = "serviceAccount:${data.google_project.my_project.number}-compute@developer.gserviceaccount.com"
}

output "baid_name" {
      value = local.baid_name
}

output "project_number" {
      value = local.project_number
}
