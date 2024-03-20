#!/bin/bash

set -euo pipefail

source '_env_gaic.sh'
# [DIRENV] layout ricc_gcloud
BUILD_SA="$PN@cloudbuild.gserviceaccount.com"
COMPUTE_SA="$PROJECT_NUMBER-compute@developer.gserviceaccount.com"

echodo gcloud --project "$PROJECT_ID" iam roles list
# echodo gcloud --project "$PROJECT_ID" iam roles create  \
#     --service-account "$PN"@cloudbuild.gserviceaccount.com \
#     roles/artifactregistry.reader

gcloud projects add-iam-policy-binding  "$PROJECT_ID" \
   --member="serviceAccount:$BUILD_SA" \
   --role=roles/artifactregistry.admin
#   --role=roles/artifactregistry.reader
gcloud projects add-iam-policy-binding  "$PROJECT_ID" \
   --member="serviceAccount:$COMPUTE_SA" \
   --role=roles/artifactregistry.admin

# boldout "Granting the default compute service account access to ${AR_REPO}"
# gcloud -q artifacts repositories add-iam-policy-binding \
#     --project "${PROJECT}" --location "${REGION}" cd-custom-targets \
#     --member=serviceAccount:$(gcloud -q projects describe $PROJECT --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
#     --role="roles/artifactregistry.reader" > /dev/null

echo All good.
