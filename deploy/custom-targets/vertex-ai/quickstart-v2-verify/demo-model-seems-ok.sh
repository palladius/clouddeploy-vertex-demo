#! /bin/bash

############################################################################################################
# This is a copy of `model-seems-ok.sh`:
#
# * `model-seems-ok.sh`: do NOT touch (as its downloaded from the Cloud and uses CD values to work, see `skaffold.yaml`)
# * `demo-model-seems-ok.sh`:  I can touch and play with locally.
#
# This is a local copy to wow the `astants` (bystanders) with model being called from local CURL
############################################################################################################

echo '⛔⛔ Note this is a dupe script for DemoVegas purposes. Do not spend too much time maintaining this. ⛔⛔'

SCRIPT_VER="1.12local"
INPUT_DATA_FILE="${1:-california-input-github.json}"
TEMPORARY_BYPASS="false" # for local demo

# This is for the local
if [ -f _env_gaic.sh ]; then
    source '_env_gaic.sh' # NO! This is executed from Github download - you cannot add it here!
fi
############################################################################################################
# IMPORTANT TODOs: For the moment, the script
# b/1: script is broken if you remove TEMPORARY_BYPASS => fix it (de to gcloud auth and gcloud missing!)
# b/2: script uses a static model you should use `CLOUD_DEPLOY_customTarget_vertexAIEndpoint` instead
# Sample CLOUD_DEPLOY_customTarget_vertexAIEndpoint="projects/rick-and-nardy-demo/locations/us-central1/endpoints/demo24-preprod"
############################################################################################################

############################################################################################################
# 20240322 v1.12 Branched into Vegas "demo-model-seems-ok.sh" to test locally. Multiplied by 100k as per Ivan docs.
# -> BRANCHED into Vegas "demo-model-seems-ok.sh"
# 202403?? v1.11 somewhat I added back the source '_env_gaic.sh' which breaks the skaffold verify.
# 20240322 v1.10 still problem. Removing it
# 20240322 v1.9 removed the TEMP bypass. lets see.
# 20240322 v1.8 Adding CLOUD_DEPLOY_customTarget_vertexAIEndpoint which finally allows me to customize the output to do the CURL to the proper ENDPOINT.
# 20240322 v1.7 added a TEMPORARY_BYPASS
# 20240322 v1.6 added AUTHORIZATION_BEARER depending if you have gcloud or not
# 20240322 v1.5 fixed PN and gcloud
# 20240321 v1.4 fixed for california and better error handling.
# 20240321 v1.2 more env vars and adding version to the script, since this is invoked from GH and has different lifecycle :)
############################################################################################################

# Usage:
# - ./model-seems-ok.sh (sensible defaults)
# - MIN_VALUE=8000 MAX_VALUE=9000 ./model-seems-ok.sh (make your own values by setting these TWO env vars)
#
# California House price comes around 1..4.
MIN_VALUE="${MIN_VALUE:-70000}"
MAX_VALUE="${MAX_VALUE:-500000}"


# this scripts calls the MODEL and checks if it works.
echo "===================================================================================="
echo "🚀 $0 v$SCRIPT_VER - start at $(date)"
echo "🚀 Testing Verify - always returning TRUE unless ARGV[1] is 'FAIL'"
#EMOJI="🚀"
echo "Some sample CloudDeploy variables which might come handy:"
echo "🌳 USER: $USER" # tree as ENVIRONMENT :)
echo "🌳 TERM: $TERM" # tree as ENVIRONMENT :)
echo "🌳 TERM_PROGRAM: $TERM_PROGRAM" # tree as ENVIRONMENT :)
# These are documented in: https://cloud.google.com/deploy/docs/verify-deployment
echo "🚀 TARGET_TYPE: $TARGET_TYPE"
echo "🚀 CLOUD_DEPLOY_LOCATION: $CLOUD_DEPLOY_LOCATION"
echo "🚀 CLOUD_DEPLOY_DELIVERY_PIPELINE: $CLOUD_DEPLOY_DELIVERY_PIPELINE"
echo "🚀 CLOUD_DEPLOY_TARGET: $CLOUD_DEPLOY_TARGET"
echo "🚀 CLOUD_DEPLOY_PROJECT: $CLOUD_DEPLOY_PROJECT"
echo "🚀 CLOUD_DEPLOY_RELEASE: $CLOUD_DEPLOY_RELEASE"
echo "🚀 CLOUD_DEPLOY_ROLLOUT: $CLOUD_DEPLOY_ROLLOUT"
echo "🚀 CLOUD_DEPLOY_JOB_RUN: $CLOUD_DEPLOY_JOB_RUN"
echo "🚀 CLOUD_DEPLOY_PHASE: $CLOUD_DEPLOY_PHASE"
echo "CD Parameters now: see https://cloud.google.com/deploy/docs/parameters"
# customTarget/vertexAIAliases
echo "📊 customTarget:      $customTarget"
#echo "📊 VERTEXAIALIASES:   $VERTEXAIALIASES"
#echo "📊 VERTEX_AI_ALIASES: $VERTEX_AI_ALIASES"
#echo "📊 VERTEXAI_ALIASES:  $VERTEXAI_ALIASES"
echo "📊 CLOUD_DEPLOY_customTarget_vertexAIEndpoint: $CLOUD_DEPLOY_customTarget_vertexAIEndpoint"
echo "📊📊 Vertex-grepping ENVs BEGIN"
#env | grep -i vertex # echo "📊 vertexAIAliases: $vertexAIAliases"
#printenv | grep -i vertex # echo "📊 vertexAIAliases: $vertexAIAliases"
echo "📊📊  Vertex-grepping ENVs END"
echo "===================================================================================="

if [ "$TEMPORARY_BYPASS" = "true" ] ; then
    echo "$0 ✅ [TEMPORARY_BYPASS=$TEMPORARY_BYPASS] Success v$SCRIPT_VER (I might need this to fill in all the targets, for example)"
    exit 0
fi

if [ "${1:-nada}" = "FAIL" ] ; then
    echo "$0 [QUICK_TEST] ⛔ FAILING"
    exit 42
#else
#    echo "$0 [QUICK_TEST] ✅ SUCCESS (While I wait for Ivan's magic cURL)"
#    exit 0
fi

## for Demo purporses pre Ivan fix:
# 1. if dev2preprod -> always GOOD
# 1. if preprod2prod -> I call the URL and I go further GOOD

if [ "vertex-dev" = "$CLOUD_DEPLOY_TARGET" ] ; then
    echo "$0 [QUICK_TEST] ✅ SUCCESS (While I wait for Ivan's magic cURL)"
    exit 0
else
    echo "$0 [QUICK_TEST] CLOUD_DEPLOY_TARGET=$CLOUD_DEPLOY_TARGET is NOT dev: continuing.."
fi

# [alpine-wget] 🚀 CLOUD_DEPLOY_TARGET: vertex-dev

set -euo pipefail

# download ENV vars
# Page: "https://github.com/palladius/clouddeploy-vertex-demo/blob/main/deploy/custom-targets/vertex-ai/quickstart-v2-verify/_env_gaic.sh"
wget "https://raw.githubusercontent.com/palladius/clouddeploy-vertex-demo/main/deploy/custom-targets/vertex-ai/quickstart-v2-verify/_env_gaic.sh"   -O .github_env_vars.sh
source '.github_env_vars.sh'
echo  '.github_env_vars.sh sourced'

if [ -f "$INPUT_DATA_FILE" ] ; then
    echo "INPUT_DATA_FILE=$INPUT_DATA_FILE found: no action"
else
    echo "downloading INPUT_DATA_FILE from github.."
    wget "https://raw.githubusercontent.com/palladius/clouddeploy-vertex-demo/main/deploy/custom-targets/vertex-ai/quickstart-v2-verify/california-input.json" -O "$INPUT_DATA_FILE"
    cat "$INPUT_DATA_FILE"
    # exit 43
fi

MODEL_ID="$DEMO_MODEL_ID"

CORRECT_ENDPOINT_ID="${CORRECT_ENDPOINT_ID:-$DEV_ENDPOINT_ID}" # todo change by target

set -euo pipefail

echo "-------------"
echo "ARGS ($#): '$*'"
echo "ENV vars:"
echo "🌱 DEV_ENDPOINT_ID : $DEV_ENDPOINT_ID (Using THIS)"
echo "🌱 PROD_ENDPOINT_ID: $ENDPOINT_ID     "
echo "🌱 CORRECT_ENDPOINT_ID: $CORRECT_ENDPOINT_ID  (Using DEV - todo should be depending on TARGET..)"
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
# I only need this until Ivan provides me with a magic cURL for this model
############################################
# echo "Testing Verify - always returning TRUE unless ARGV[1] is 'FAIL'"
# if [ "${1:-nada}" = "FAIL" ] ; then
#     echo "$0 [QUICK_TEST] FAILING"
#     exit 42
# else
#     echo "$0 [QUICK_TEST] SUCCESS (While I wait for Ivan's magic cURL)"
#     exit 0
# fi
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
PROJECT_NUMBER="$PROJECT_NUMBER2"
echo "PROJECT_NUMBER: $PROJECT_NUMBER"
#exit 42
#######################################################################

AUTHORIZATION_BEARER=""
if which gcloud ; then
  AUTHORIZATION_BEARER="Authorization: Bearer $(gcloud auth print-access-token)"
else
  AUTHORIZATION_BEARER=""
fi

#echo Note I removed gcloud auth so this will only work on CD
#echo "AUTHORIZATION_BEARER: $AUTHORIZATION_BEARER"
echo "Using Endpoint: $CORRECT_ENDPOINT_ID"

curl \
    -X POST \
    -H "$AUTHORIZATION_BEARER" \
    -H "Content-Type: application/json" \
    https://us-central1-aiplatform.googleapis.com/v1/projects/${PROJECT_NUMBER}/locations/us-central1/endpoints/${CORRECT_ENDPOINT_ID}:predict \
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
#if cat output.json | jq .error.code | egrep '^2' ; then
if cat output.json | grep -q predictions; then
    echo "✅ output.json seems to contain predictions: all good"
else
    ERR_CODE="$(cat output.json | jq .error.code)"
    echo "- ❎ ERROR CODE: $ERR_CODE"
    echo "- ❎ ERROR MESSAGE: $(cat output.json | jq .error.message)"
    echo "❎ While the cURL returned correctly, the endpoint yielded an application-level error: Exiting."
    echo "--"
    cat output.json | jq .error
    exit "$ERR_CODE"
fi

# this is in 100'000$ accordin to Docs.
PREDICTED_HOUSE_PRICE_COEFFICIENT=$( cat output.json | jq .predictions[0] )
HOUSE_PRICE=$(echo "scale=1; $PREDICTED_HOUSE_PRICE_COEFFICIENT * 100000 / 1" | bc)

echo
echo
echo  "🏙️ Predicted 🇺🇸 🧸 California 🏡 house price: ${HOUSE_PRICE} 💲"
echo
echo

# num1=7.2
# num2=7.5

# awk -v n1=$num1 -v n2=$num2 'BEGIN {if (n1>n2) print n1" is greater than "n2; else print n1" is not greater than "n2}'


# MIN_VALUE=1000.50
# MAX_VALUE=5000.00
# HOUSE_PRICE=2500.75

if (( $(bc <<< "$HOUSE_PRICE >= $MIN_VALUE && $HOUSE_PRICE <= $MAX_VALUE") )); then
    echo "[California🇺🇸🧸] 👍 HOUSE_PRICE=$HOUSE_PRICE is within range. Model seems good!"
    exit 0
else
    echo "[California🇺🇸🧸] 👎 HOUSE_PRICE=$HOUSE_PRICE is outside range [$MIN_VALUE, $MAX_VALUE]"
    exit 142
fi
