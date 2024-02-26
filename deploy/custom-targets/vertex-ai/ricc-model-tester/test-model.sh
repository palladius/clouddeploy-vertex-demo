#! /bin/bash

# Mdeol: test-model
# Model artifact location gs://cloud-samples-data/vertex-ai/model-deployment/models/boston/model
ENDPOINT_ID="quickstart-prod"
#ENDPOINT_ID="prod-endpoint"
#PROJECT_ID=rick-and-nardy-demo
PROJECT_NUMBER="849075740253"
#INPUT_DATA_FILE="INPUT-JSON"
INPUT_DATA_FILE="${1:-input.json}"

set -euo pipefail

echo "Testing model on INPUT_DATA_FILE: $INPUT_DATA_FILE"

#######################################################################
# works but its slower - todo make it cleaner when everything works
#######################################################################
#echo "PROJECT_ID: $PROJECT_ID"
#gcloud projects describe "$PROJECT_ID" --format="value(projectNumber)"
#export PROJECT_NUMBER2="$(gcloud projects describe "$PROJECT_ID" --format="value(projectNumber)")"
#echo "PROJECT_NUMBER2: $PROJECT_NUMBER2"
#exit 42
#######################################################################

curl \
    -X POST \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    -H "Content-Type: application/json" \
    https://us-central1-aiplatform.googleapis.com/v1/projects/${PROJECT_NUMBER}/locations/us-central1/endpoints/${ENDPOINT_ID}:predict \
    -d "@${INPUT_DATA_FILE}" 2>/dev/null \
       > output.json  # | tee output.json

#echo
echo "🕸️  cURL returned: '$?'"
echo -en "🏙️ Predicted 🇺🇸 Boston 🏡 house price in 💲: "
    cat output.json | jq .predictions[0][0]
