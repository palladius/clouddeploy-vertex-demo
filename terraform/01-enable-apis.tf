
resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "deploy" {
  service = "deploy.googleapis.com"
}
