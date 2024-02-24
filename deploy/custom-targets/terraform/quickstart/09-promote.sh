#!/bin/bash

echo i havent done it yet. Try it on Monday

exit 42

gcloud deploy releases promote --release=release-001 --delivery-pipeline=tf-network-pipeline --project=$PROJECT_ID --region=$REGION
