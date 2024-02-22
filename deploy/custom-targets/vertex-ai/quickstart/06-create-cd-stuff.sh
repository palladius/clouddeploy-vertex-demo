#!/bin/bash
#export TMPDIR=$(mktemp -d)
export TMPDIR=/tmp/tmp.Fe9QrUEzpe/

mkdir -p "$TMPDIR"

echo "1. Replacing vars in this dir: $TMPDIR"
./replace_variables.sh -p $PROJECT_ID -r $REGION -e $ENDPOINT_ID -t $TMPDIR

echo 2. Lets now apply CD config..
gcloud deploy apply --file=$TMPDIR/clouddeploy.yaml --project=$PROJECT_ID --region=$REGION

