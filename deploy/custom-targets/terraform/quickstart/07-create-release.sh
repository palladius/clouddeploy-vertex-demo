#!/bin/bash

set -euo pipefail

RELEASE_NAME="${1:-release-001}"

# fails if var not set so were good.
echo "DEV_BACKEND_BUCKET: $DEV_BACKEND_BUCKET"
echo "RELEASE_NAME: $RELEASE_NAME"

gcloud deploy releases create "$RELEASE_NAME" --delivery-pipeline=tf-network-pipeline --project=$PROJECT_ID --region=$REGION --source=configuration --deploy-parameters="customTarget/tfEnableRenderPlan=true"

