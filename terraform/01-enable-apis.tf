
# Enable the Cloud Deploy, Cloud Build, GKE, Cloud Run, and Cloud Storage APIs.

resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "clouddeploy" {
  service = "clouddeploy.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifactregistry" {
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "storage" {
  service = "storage.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "aiplatform" {
  service = "aiplatform.googleapis.com"
  disable_on_destroy = false
}
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_on_destroy = false
}
#
# TODO Add
# Vertex AI API
# Dataform API
