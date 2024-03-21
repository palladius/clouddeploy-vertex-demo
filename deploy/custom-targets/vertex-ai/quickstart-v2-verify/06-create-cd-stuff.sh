#!/bin/bash

source '_env_gaic.sh'

set -euo pipefail

echo "===================================="
echo "TMPDIR:       $TMPDIR"
echo "VAI_PIPELINE: $VAI_PIPELINE"
echo "REGION:       $REGION"
echo "ENDPOINT NAMES:"
echo " 1 dev:  $DEV_ENDPOINT_ID"
echo " 2 stg:  $PREPROD_ENDPOINT_ID"
echo " 2 prd:  $ENDPOINT_ID "
echo "===================================="

mkdir -p "$TMPDIR"

echo "1. Replacing vars in this dir: $TMPDIR"
./replace_variables.sh -p $PROJECT_ID -r $REGION -e $ENDPOINT_ID -t $TMPDIR -d $DEV_ENDPOINT_ID -q $PREPROD_ENDPOINT_ID

echo 2. Lets now apply CD config..
gcloud deploy apply --file=$TMPDIR/clouddeploy.yaml --project=$PROJECT_ID --region="$REGION"


# gcloud deploy automations delete promote-no-need-bcs-verify
# gcloud deploy automations delete promote
