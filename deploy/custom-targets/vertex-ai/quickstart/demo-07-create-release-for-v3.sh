#!/bin/bash

#export TMPDIR=/tmp/tmp.Fe9QrUEzpe/

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 [1|2|3|v1|v2|v3]"
    exit 1
fi
# Validate the argument format
if [[ ! $1 =~ ^(v?[1-3])$ ]]; then
    echo "Invalid argument. Accepted formats: 1, 2, 3, v1, v2, v3"
    exit 1
fi
#echo RELEASE_NUMBER: $RELEASE_NUMBER

# since i only used 1 so far and ivan wants to use 1 and 3:
DEFAULT_MODEL_VERSION="2"
MODEL_VERSION="${1:-$DEFAULT_MODEL_VERSION}"

# to reset: rm .release_counter.txt
_auto_increase_release_number() {
    COUNTER_FILE=".release_counter.txt"
    # Create the counter file if it doesn't exist
    if [ ! -f "$COUNTER_FILE" ]; then
        echo "000" > "$COUNTER_FILE"
    fi
    # Read the current counter value
    CURRENT_COUNT=$(cat "$COUNTER_FILE")
    # Increment the counter
    NEXT_COUNT=$((CURRENT_COUNT + 1))
    # Format with leading zeros (up to 3 digits)
    RELEASE_NUMBER=$(printf "%03d" $NEXT_COUNT)
    # Overwrite the counter file with the new value
    echo "$NEXT_COUNT" > "$COUNTER_FILE"
    # 001, ...
    echo $RELEASE_NUMBER
}

REL_NAME="relv3-model$MODEL_VERSION-$(_auto_increase_release_number)"


echo "========================================================================"
echo "CD_DEPLOYABLE_MODEL: $CD_DEPLOYABLE_MODEL"
echo "REL_NAME: $REL_NAME"
echo "MODEL_VERSION:  $MODEL_VERSION"
echo "VAI_PIPELINE: $VAI_PIPELINE"
echo "========================================================================"

# ok wuith rel11 moving back to normal one...
# rel10b: same as above, but I changed pipeline to an entirely NEW one.
# rel10: recreating a NEW empty pipeline. maybe it doesnt work with old one. Fixed by copying the skaffold (broken)
#        directly from https://github.com/GoogleCloudPlatform/cloud-deploy-samples/blob/main/custom-targets/vertex-ai/quickstart/configuration/skaffold.yaml
# {"errorCode":"CONFIG_FILE_PARSING_ERR","errorMessage":"error parsing skaffold configuration file: unable to parse config: yaml: unmarshal errors:\n  line 9: field container not found in type v4beta7.VerifyContainer"}
# 11mar rel09: rm -rf out/, exec 06 and 07 scripts.. im SURE i fixed skaffold!
# 🚨 Same ERROR -> I'll relaunch wiht 06 and 07 scripts and also remove out/
# 11mar rel07: Fixing skaffold (note i reversed 8 and 7)
# ERROR # #{"errorCode":"CONFIG_FILE_PARSING_ERR","errorMessage":"error parsing skaffold configuration file: unable to parse config: yaml: unmarshal errors:\n  line 10: field container not found in type v4beta7.Action"}
# 11mar rel08: Substituting replace_vars with also dev EP..  DEV model is now 2371068237996621824 correclty https://screenshot.googleplex.com/ByaPQadtnsRLJLy
# 11mar rel06: After creating the dev-endpoint (with wrong model_id)
# 11mar rel05: fixed other stuff in configuration/ and pushing rel5 afterwards. out/ was broken so i moved it out. It would created out/configuration/ over and over. Maybe a mktmp is better :)
# 11mar rel04: moved from projects/rick-and-nardy-demo/locations/us-central1/endpoints/quickstart-prod to projects/rick-and-nardy-demo/locations/us-central1/endpoints/quickstart-dev
# 11mar rel03: pushed to dev 1st time
# 11mar -----  ricc creates dev target before prod. Super weird mutation: https://screenshot.googleplex.com/8L2yiyDY8aQ8Qpb
# 22feb rel02: same -> prod
# 22feb rel01: first one -> prod

echo "🚀 Deploying release '$REL_NAME'.."
# vertex-ai-cloud-deploy-pipeline
echodo gcloud deploy releases create "$REL_NAME" \
    --delivery-pipeline=$VAI_PIPELINE \
    --project=$PROJECT_ID \
    --region=$REGION \
    --source=$TMPDIR/configuration \
    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/$CD_DEPLOYABLE_MODEL@$MODEL_VERSION"

