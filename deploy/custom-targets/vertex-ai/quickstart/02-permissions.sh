#!/bin/bash

# from https://github.com/GoogleCloudPlatform/cloud-deploy-samples/blob/main/custom-targets/vertex-ai/quickstart/QUICKSTART.md

set -euo pipefail

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$(gcloud projects describe $PROJECT_ID \
    --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
    --role="roles/clouddeploy.jobRunner"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$(gcloud projects describe $PROJECT_ID \
    --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
    --role="roles/clouddeploy.viewer"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$(gcloud projects describe $PROJECT_ID \
    --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
    --role="roles/aiplatform.user"

echo "TODO For automations give permission to CD to also run rollouts (releaser). Total roles here in comments:"
# I Gave it to make sure it works these:
# * Cloud Build Editor
# * Cloud Deploy Approver
# These already were there:
# * Cloud Deploy Runner
# * Cloud Deploy Viewer
# * Cloud Run Admin
# * Compute Network Admin
# * Service Account User
# * Storage Object User
# * Vertex AI user

# For rollouts:
# # Currently: Cloud Deploy %w{Approver Runner Viewer}
# # Adding:
# # # * releaser
