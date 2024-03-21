#!/bin/bash

set -euo pipefail

# https://cloud.google.com/deploy/docs/subscribe-deploy-notifications

CD_SA="service-${PROJECT_NUMBER}@gcp-sa-clouddeploy.iam.gserviceaccount.com"

echo "Cloud Deploy SvcAcct: $CD_SA"
# done it via UI today..
#echo "TODO(ricc): prgrammatically give them ''ervice Management > Cloud Deploy Service Agent '' as per https://cloud.google.com/deploy/docs/subscribe-deploy-notifications"
gcloud projects add-iam-policy-binding $PROJECT_ID \
       --member=serviceAccount:"$CD_SA" \
       --role="roles/clouddeploy.serviceAgent"

gcloud pubsub topics create clouddeploy-resources
gcloud pubsub topics create clouddeploy-operations
gcloud pubsub topics create clouddeploy-approvals
gcloud pubsub topics create clouddeploy-advances

# Sending email with Integrations :)
