#!/bin/bash

set -euo pipefail

INPUT_DATA_FILE="${1:-california-input-github.json}"

echo Testing DEV and PROD endpoints. I dont care re preprod. I use gcloud.
echo "Using JSON in: $INPUT_DATA_FILE"
AUTHORIZATION_BEARER="Authorization: Bearer $(gcloud auth print-access-token)"

for ENDPOINT_ID in demo24-dev demo24-prod ; do
    echo "Using Endpoint: $ENDPOINT_ID"

    curl \
        -X POST \
        -H "$AUTHORIZATION_BEARER" \
        -H "Content-Type: application/json" \
        https://us-central1-aiplatform.googleapis.com/v1/projects/${PROJECT_NUMBER}/locations/us-central1/endpoints/${ENDPOINT_ID}:predict \
        -d "@${INPUT_DATA_FILE}" 2>/dev/null \
        > "output.$ENDPOINT_ID.json"

    cat "output.$ENDPOINT_ID.json" | jq # .predictions

done
