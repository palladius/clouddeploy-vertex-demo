#! /bin/bash

# needs skaffold.yaml
RELNAME="${1:-XXX}"

cd cloud-deploy/ &&
gcloud deploy releases create "rel-$RELNAME" \
   --project="rick-and-nardy-demo" \
   --region=us-central1 \
   --delivery-pipeline='ricc-verify-metrics'  \
   --images=my-app-image=gcr.io/cloudrun/hello@sha256:98cdb98c2d97a67d5e9183beedfec98ca9d5967acd874409b4800bf4d1a51710
