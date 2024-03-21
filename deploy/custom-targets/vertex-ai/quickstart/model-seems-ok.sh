#! /bin/bash

# Copied from ../ricc-model-tester/

# Usage:
# - ./model-seems-ok.sh (sensible defaults)
# - MIN_VALUE=8000 MAX_VALUE=9000 ./model-seems-ok.sh (make your own values by setting these TWO env vars)
#
# this scripts calls the MODEL and checks if it works.

source '_env_gaic.sh'

set -euo pipefail

# Model artifact location gs://cloud-samples-data/vertex-ai/model-deployment/models/boston/model
#ENDPOINT_ID="quickstart-prod"
#MODEL_NAME="california_reg_model" # useless! there's two!
MODEL_NAME=$DEMO_MODEL_NAME
#MODEL_ID="3485927948584747008"
MODEL_ID="$DEMO_MODEL_ID"
VERSION_ID="1"
# 🐼 gcloud ai endpoints list
# Using endpoint [https://us-central1-aiplatform.googleapis.com/]
# ENDPOINT_ID          DISPLAY_NAME
# demo24-dev           demo24-dev
# demo24-prod          demo24-prod
# demo24-preprod       prod-endpoint
# quickstart-prod      prod-endpoint
# 2130899714118254592  ricc-manhouse-dev
ENDPOINT_ID="demo24-prod"
ENDPOINT_ID="demo24-dev"
#ENDPOINT_ID=3485927948584747008
#PROJECT_ID='rick-and-nardy-demo'
#export PROJECT_NUMBER="$(gcloud projects describe "$PROJECT_ID" --format="value(projectNumber)")"
#PROJECT_NUMBER="849075740253"
INPUT_DATA_FILE="${1:-california-input.json}"

# House price comes around 8000.
MIN_VALUE="${MIN_VALUE:-42}"
MAX_VALUE="${MAX_VALUE:-5000}"
# this should fail with 5000 and not fail with

set -euo pipefail

echo "-------------"
echo "ARGS ($#): '$*'"
echo "ENV vars:"
echo "🌱 ENDPOINT_ID: $ENDPOINT_ID"
echo "🌱 INPUT_DATA_FILE: $INPUT_DATA_FILE"
echo "🌱 MODEL_NAME: $MODEL_NAME"
echo "🌱 MODEL_ID: $MODEL_ID"
echo "House value:"
echo "🏡 MIN_VALUE: $MIN_VALUE"
echo "🏡 MAX_VALUE: $MAX_VALUE"
echo "-------------"
# Specifying the explicit project id in case this came to but me in the future.
############################################
# REMOVEME - QUICK_TEST enabled of verify
# ./model-seems-ok.sh        -> OK
# ./model-seems-ok.sh FAIL   -> ERR
############################################
echo "Testing Verify - always returning TRUE unless ARGV[1] is 'FAIL'"
if [ "${1:-nada}" = "FAIL" ] ; then
    echo "$0 [QUICK_TEST] FAILING"
    exit 42
else
    echo "$0 [QUICK_TEST] SUCCESS (While I wait for Ivan's magic cURL)"
    exit 0
fi


############################################
# /removeme QUICK_TEST
############################################

echo "🧠 Testing model on project '$PROJECT_ID' on INPUT_DATA_FILE: $INPUT_DATA_FILE"
echo "🧠 Verifying the house price is between $MIN_VALUE and $MAX_VALUE"


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

curl_ret="$?"
echo "🕸️  cURL returned: '$curl_ret' (0 is good)"
if [ "0" -eq "$curl_ret" ]; then
    echo All good. cURL found the endpoint. Lets now see the values...

else
    echo cURL returned ERROR: "$curl_ret". Probably the endpoint wasnt found or is down.
fi

# Inspecting the output.json
# Note that when it wont fail, probably this code needs fixing :)
if cat output.json | jq .error.code | egrep '^2' ; then
    echo "output.json seems 2XX: all good"
else
    ERR_CODE="$(cat output.json | jq .error.code)"
    echo "- ERROR CODE: $ERR_CODE"
    echo "- ERROR MESSAGE: $(cat output.json | jq .error.message)"
    echo "❎ While the cURL returned correctly, the endpoint yielded an application-level error: Exiting."
    echo "--"
    cat output.json | jq .error
    exit "$ERR_CODE"

fi

HOUSE_PRICE="$(cat output.json | jq .predictions[0][0])"
echo  "🏙️ Predicted 🇺🇸 Boston 🏡 house price in 💲: '$HOUSE_PRICE'"


# num1=7.2
# num2=7.5

# awk -v n1=$num1 -v n2=$num2 'BEGIN {if (n1>n2) print n1" is greater than "n2; else print n1" is not greater than "n2}'


# MIN_VALUE=1000.50
# MAX_VALUE=5000.00
# HOUSE_PRICE=2500.75

if (( $(bc <<< "$HOUSE_PRICE >= $MIN_VALUE && $HOUSE_PRICE <= $MAX_VALUE") )); then
    echo "[Gemini] 👍 HOUSE_PRICE=$HOUSE_PRICE is within range. Model seems good!"
    exit 0
else
    echo "[Gemini] 👎 HOUSE_PRICE=$HOUSE_PRICE is outside range [$MIN_VALUE, $MAX_VALUE]"
    exit 142
fi


# if [ "$HOUSE_PRICE" -gt "$MAX_VALUE" ]; then
#   echo "HOUSE_PRICE $HOUSE_PRICE is greater than $MAX_VALUE: This is too much so I dont trust this model."
#   exit 42
# else
#   echo "HOUSE_PRICE is not too big, good."
# fi

# if [ "$num1" -gt "$num2" ]; then
#     echo "$num1 is greater than $num2"
# else
#     echo "$num1 is not greater than $num2"
# fi
