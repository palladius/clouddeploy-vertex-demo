variable "project_id" {
  description = "The ID of your Google Cloud project."
  type        = string
  # TODO(ricc): remove when done.
  default     = "rick-and-nardy-demo"
}

# variable "project_number" {
#   description = "The NUMBER of your Google Cloud project (could be autoinferred by project id but Im a TF newbie)"
#   type        = string
#   # TODO(ricc): remove when done.
#   # (gcloud projects describe "$PROJECT_ID"   --format="value(projectNumber)"
#   default     = "849075740253"
# }

variable "region" {
  description = "The region where you want to create your resources."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where you want to create your resources."
  type        = string
  default     = "us-central1-a"
}
