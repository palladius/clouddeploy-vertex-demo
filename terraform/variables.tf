variable "project_id" {
  description = "The ID of your Google Cloud project."
  type        = string
  # TODO(ricc): remove when done.
  default     = "rick-and-nardy-demo"
}

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
