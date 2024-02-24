#!/bin/bash

set -euo pipefail

# fails if var not set so were good.
echo DEV_BACKEND_BUCKET: $DEV_BACKEND_BUCKET

gcloud deploy releases create release-001 --delivery-pipeline=tf-network-pipeline --project=$PROJECT_ID --region=$REGION --source=configuration --deploy-parameters="customTarget/tfEnableRenderPlan=true"

