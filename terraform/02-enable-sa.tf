# google_project_iam_member: Non-authoritative. Updates the IAM policy to grant a role to a new member. Other members for the role for the project are preserved.
# You should use MEMBER as NON AUTHORATIVE

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#     --member=serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
#     --role="roles/clouddeploy.jobRunner"


# this is SAFE
resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/clouddeploy.jobRunner"
  member  =  "serviceAccount:${local.project_number}-compute@developer.gserviceaccount.com"

}
resource "google_project_iam_member" "iam_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
#   member = "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com"
#
  member = "serviceAccount:${local.project_number}-compute@developer.gserviceaccount.com"
}


# # IAM BINDING is NON additive, its NOT SAFE
# Will remove all CD jobrunners who are not in this list.
# resource "google_project_iam_binding" "clouddeploy_job_runner" {
#   project = var.project_id
#   role    = "roles/clouddeploy.jobRunner"

#   members = [
#     "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com",
#   ]
# }


# # DuetAI: Sure. Here is the Terraform code to add the clouddeploy.jobRunner role to the service account $(gcloud projects describe "$PROJECT_ID" \ --format="value(projectNumber)")-compute@developer.gserviceaccount.com:

# resource "google_project_iam_binding" "clouddeploy_job_runner" {
#   project = var.project_id
#   role    = "roles/clouddeploy.jobRunner"

#   members = [
#     "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com",
#   ]
# }

# # Here is the Terraform code to add the iam.serviceAccountUser role to the service account $(gcloud projects describe "$PROJECT_ID" \ --format="value(projectNumber)")-compute@developer.gserviceaccount.com:

# resource "google_project_iam_binding" "iam_service_account_user" {
#   project = var.project_id
#   role    = "roles/iam.serviceAccountUser"

#   members = [
#     "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com",
#   ]
# }



# gcloud iam service-accounts add-iam-policy-binding $PROJECT_NUMBER-compute@developer.gserviceaccount.com \
#     --member=serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
#     --role="roles/iam.serviceAccountUser" \
#     --project="$PROJECT_ID"


# resource "google_project_iam_binding" "iam_service_account_user_roberto" {
#   project = var.project_id
#   role    = "roles/iam.serviceAccountUser"

#   members = [
#     "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com",
#   ]
# }
