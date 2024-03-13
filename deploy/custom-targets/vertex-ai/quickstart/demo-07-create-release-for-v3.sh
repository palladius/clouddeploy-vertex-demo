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
echo "CD_DEPLOYABLE_MODEL_ID: $CD_DEPLOYABLE_MODEL_ID"
echo "REL_NAME: $REL_NAME"
echo "MODEL_VERSION:  $MODEL_VERSION"
echo "VAI_PIPELINE: $VAI_PIPELINE"
echo "========================================================================"

echo "🚀 Deploying release '$REL_NAME'.."
# vertex-ai-cloud-deploy-pipeline
#echodo
# gcloud deploy releases create "$REL_NAME" \
#     --delivery-pipeline=$VAI_PIPELINE \
#     --project=$PROJECT_ID \
#     --region=$REGION \
#     --source=$TMPDIR/configuration \
#     --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/$CD_DEPLOYABLE_MODEL_ID@$MODEL_VERSION"

gcloud deploy releases create "$REL_NAME-ohne" \
    --delivery-pipeline=$VAI_PIPELINE \
    --project=$PROJECT_ID \
    --region=$REGION \
    --source=$TMPDIR/configuration \
    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/$CD_DEPLOYABLE_MODEL_ID"

