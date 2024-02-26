#!/bin/bash

set -euo pipefail
echo PROJECT_ID: $PROJECT_ID


gcloud storage buckets create gs://$PROJECT_ID-$REGION-tf-dev-backend --project $PROJECT_ID --location $REGION
export DEV_BACKEND_BUCKET=$PROJECT_ID-$REGION-tf-dev-backend
gcloud storage buckets create gs://$PROJECT_ID-$REGION-tf-prod-backend --project $PROJECT_ID --location $REGION
export PROD_BACKEND_BUCKET=$PROJECT_ID-$REGION-tf-prod-backend
