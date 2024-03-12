#!/bin/bash

set -euo pipefail

echo '😎 Now Inspecting aliases in the deployed model:'
#gcloud ai endpoints describe $ENDPOINT_ID --region $REGION --project $PROJECT_ID
# gcloud ai endpoints describe $DEV_DEMO_ENDPOINT_ID --region $REGION --project $PROJECT_ID
# gcloud ai endpoints describe $PROD_DEMO_ENDPOINT_ID --region $REGION --project $PROJECT_ID

echo '😎 Lets now see if aliases are assigned:'
CD_DEPLOYABLE_MODEL_ID="3485927948584747008"
gcloud ai models describe "$CD_DEPLOYABLE_MODEL_ID" --region $REGION --project $PROJECT_ID --format "(versionAliases)"
#echodo gcloud ai models describe "california_reg_model" --region $REGION --project $PROJECT_ID --format "(versionAliases)"
#gcloud ai models describe "$CD_DEPLOYABLE_MODEL" --region $REGION --project $PROJECT_ID --format "(versionAliases)"
