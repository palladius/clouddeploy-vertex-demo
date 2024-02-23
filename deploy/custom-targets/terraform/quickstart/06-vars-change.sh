#!/bin/bash

set -euo pipefail

# fails if var not set so were good.
echo DEV_BACKEND_BUCKET: $DEV_BACKEND_BUCKET

sed -i "s/\$PROJECT_ID/${PROJECT_ID}/g" ./clouddeploy.yaml
sed -i "s/\$REGION/${REGION}/g" ./clouddeploy.yaml
sed -i "s/\$DEV_BACKEND_BUCKET/${DEV_BACKEND_BUCKET}/g" ./clouddeploy.yaml
sed -i "s/\$PROD_BACKEND_BUCKET/${PROD_BACKEND_BUCKET}/g" ./clouddeploy.yaml

echo Substitution done.

gcloud deploy apply --file=clouddeploy.yaml --project=$PROJECT_ID --region=$REGION
