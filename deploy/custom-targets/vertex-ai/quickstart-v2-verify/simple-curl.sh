#!/bin/bash

source _env_gaic.sh

set -euo pipefail

INPUT_DATA_FILE="california-input.json"
export IVAN_MODEL_ID=6853909085834706944

#echo ENDPOINT_ID: $ENDPOINT_ID

function _curl_endpoint() {
    MY_ENDPOINT="$1"
    echo "_curl_endpoint Vertex::ENDPOINT_ID: $MY_ENDPOINT"
    curl \
        -X POST \
        -H "Authorization: Bearer $(gcloud auth print-access-token)" \
        -H "Content-Type: application/json" \
        https://us-central1-aiplatform.googleapis.com/v1/projects/${PROJECT_NUMBER}/locations/us-central1/endpoints/${MY_ENDPOINT}:predict \
        -d "@${INPUT_DATA_FILE}" 2>/dev/null \
     > output-$MY_ENDPOINT.json  # | tee output.json
    cat output-$MY_ENDPOINT.json | jq

}
echo "1. Testing PROD Model by Ricc: $ENDPOINT_ID"
_curl_endpoint "$ENDPOINT_ID"

echo "1. Testing TEST (yet libfixed) Ivan Model by Ivan: $IVAN_MODEL_ID"
_curl_endpoint "$IVAN_MODEL_ID"
