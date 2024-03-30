#!/bin/bash

#export ENDPOINT_ID="quickstart-prod"

#set -euo pipefail
echo 'Creating 3 endpoints. If you see an ALREADY_EXISTS dont you worry its expected.'


# ENDPOINT_ID: "quickstart-prod"
# DEV_ENDPOINT_ID: "2371068237996621824" # https://screenshot.googleplex.com/AbYAAZu2PYd9wTz

# PREPROD
# gcloud ai endpoints create --display-name preprod-endpoint --endpoint-id "$PREPROD_ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

# # PROD
# gcloud ai endpoints create --display-name prod-endpoint    --endpoint-id "$ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

# # DEV
# gcloud ai endpoints create --display-name dev-endpoint     --endpoint-id "$DEV_ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

# PREPROD
gcloud ai endpoints create --display-name "$PREPROD_ENDPOINT_ID" --endpoint-id "$PREPROD_ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

# PROD
gcloud ai endpoints create --display-name "$ENDPOINT_ID"    --endpoint-id "$ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

# DEV
gcloud ai endpoints create --display-name "$DEV_ENDPOINT_ID"   --endpoint-id "$DEV_ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"

gcloud ai endpoints list

exit 0




##########################
# Vegas Slides only :)
##########################


# Creates DEV, PREPROD and PROD endpoints
for ENDPOINT in 'demo24-dev' 'demo24-preprod' 'demo24-prod' ; do
    gcloud ai endpoints create \
        --display-name "$ENDPOINT" \
        --endpoint-id "$ENDPOINT"
done
