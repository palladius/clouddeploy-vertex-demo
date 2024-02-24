#!/bin/bash

set -euo pipefail

# fails if var not set so were good.
echo DEV_BACKEND_BUCKET: $DEV_BACKEND_BUCKET
#echo PROJECT: $PROJECT

gcloud deploy rollouts describe release-001-to-tf-dev-0001 --release=release-001 --delivery-pipeline=tf-network-pipeline --project=$PROJECT_ID --region=$REGION
