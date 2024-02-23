#!/bin/bash

. ../.envrc

set -euo pipefail

echo "PROJECT_ID: $PROJECT_ID"

set -x

echo moved to Terraform.

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#     --member=serviceAccount:$(gcloud projects describe "$PROJECT_ID" \
#     --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
#     --role="roles/clouddeploy.jobRunner"

# gcloud iam service-accounts add-iam-policy-binding $(gcloud projects describe "$PROJECT_ID" \
#     --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
#     --member=serviceAccount:$(gcloud projects describe "$PROJECT_ID" \
#     --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
#     --role="roles/iam.serviceAccountUser" \
#     --project="$PROJECT_ID"
