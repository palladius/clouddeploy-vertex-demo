#!/bin/bash

source _env_gaic.sh

set -euo pipefail

INPUT_DATA_FILE="california-input.json"
export IVAN_MODEL_ID1=3030353002197155840
export IVAN_MODEL_ID2=6234664137071263744
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
    MedHouseVal=$(cat output-$MY_ENDPOINT.json | jq .predictions[0])
    # if numeric
    echo "🏚️  MedHouseVal: $MedHouseVal"
}
echo "1. Testing DEV Model by Ricc: $DEV_DEMO_ENDPOINT_ID"
_curl_endpoint "$DEV_DEMO_ENDPOINT_ID"
echo "1. Testing PROD Model by Ricc: $ENDPOINT_ID"
_curl_endpoint "$ENDPOINT_ID"

echo "2. Testing TEST (yet libfixed) Ivan Model by Ivan: $IVAN_MODEL_ID1"
_curl_endpoint "$IVAN_MODEL_ID1"
echo "3. Testing TEST (yet libfixed) Ivan Model by Ivan: $IVAN_MODEL_ID2"
_curl_endpoint "$IVAN_MODEL_ID2"

