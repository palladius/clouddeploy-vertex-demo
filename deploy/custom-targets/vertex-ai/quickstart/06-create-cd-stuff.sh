#!/bin/bash
#export TMPDIR=$(mktemp -d)
# #export TMPDIR=/tmp/tmp.Fe9QrUEzpe/
# export TMPDIR=out/ # /tmp/tmp.Fe9QrUEzpe/

set -euo pipefail

echo "===================================="
echo "TMPDIR: $TMPDIR"
echo "VAI_PIPELINE: $VAI_PIPELINE"
echo "===================================="

mkdir -p "$TMPDIR"

echo "1. Replacing vars in this dir: $TMPDIR"
./replace_variables.sh -p $PROJECT_ID -r $REGION -e $ENDPOINT_ID -t $TMPDIR -d $DEV_ENDPOINT_ID -q $PREPROD_ENDPOINT_ID

echo 2. Lets now apply CD config..
gcloud deploy apply --file=$TMPDIR/clouddeploy.yaml --project=$PROJECT_ID --region=$REGION

