#!/bin/bash

#export ENDPOINT_ID="quickstart-prod"

set -euo pipefail

# ENDPOINT_ID: "quickstart-prod"
# DEV_ENDPOINT_ID: "2371068237996621824" # https://screenshot.googleplex.com/AbYAAZu2PYd9wTz

PROD_DEMO_ENDPOINT_ID="demo-prod"
 DEV_DEMO_ENDPOINT_ID="demo-dev"

# PROD
gcloud ai endpoints create --display-name prod-endpoint --endpoint-id "$PROD_DEMO_ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

# DEV
gcloud ai endpoints create --display-name dev-endpoint --endpoint-id "$DEV_DEMO_ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

# $ gcloud ai endpoints list
# ENDPOINT_ID  DISPLAY_NAME
# demo-dev     dev-endpoint
# demo-prod    prod-endpoint
