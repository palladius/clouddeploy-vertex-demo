# google_project_iam_member: Non-authoritative. Updates the IAM policy to grant a role to a new member. Other members for the role for the project are preserved.
# You should use MEMBER as NON AUTHORATIVE

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#     --member=serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
#     --role="roles/clouddeploy.jobRunner"


# [drebes] google_project_iam_member is SAFE to add/remove

####################################################
# these are needed for the Vertex AI Quickstart
####################################################
resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/clouddeploy.jobRunner"
  member  =  "serviceAccount:${local.project_number}-compute@developer.gserviceaccount.com"
  # member  =  local.compute_service_account
}
resource "google_project_iam_member" "iam_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${local.project_number}-compute@developer.gserviceaccount.com"
}

####################################################
# these are needed for the TF Quickstart
# https://github.com/GoogleCloudPlatform/cloud-deploy-samples/blob/main/custom-targets/terraform/quickstart/QUICKSTART.md
####################################################
