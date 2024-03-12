#!/bin/bash

#export ENDPOINT_ID="quickstart-prod"

set -euo pipefail

# ENDPOINT_ID: "quickstart-prod"
# DEV_ENDPOINT_ID: "2371068237996621824" # https://screenshot.googleplex.com/AbYAAZu2PYd9wTz

# PROD
gcloud ai endpoints create --display-name prod-endpoint --endpoint-id "$ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

# DEV
gcloud ai endpoints create --display-name dev-endpoint --endpoint-id "$DEV_ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"
