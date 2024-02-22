
resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "deploy" {
  service = "clouddeploy.googleapis.com"
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

# TODO Add
# Vertex AI API
# Dataform API
