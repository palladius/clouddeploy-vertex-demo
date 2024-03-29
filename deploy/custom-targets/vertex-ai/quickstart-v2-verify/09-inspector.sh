#!/bin/bash

source _env_gaic.sh

set -euo pipefail

#echo '😎 Now Inspecting aliases in the deployed model:'
#gcloud ai endpoints describe $ENDPOINT_ID --region $REGION --project $PROJECT_ID
# gcloud ai endpoints describe $DEV_DEMO_ENDPOINT_ID --region $REGION --project $PROJECT_ID
# gcloud ai endpoints describe $PROD_DEMO_ENDPOINT_ID --region $REGION --project $PROJECT_ID

echo '😎 Lets now see if aliases are assigned:'
echo "CD_DEPLOYABLE_MODEL_ID: $CD_DEPLOYABLE_MODEL_ID"
#CD_DEPLOYABLE_MODEL_ID="3485927948584747008"
#echodo gcloud ai models describe "$CD_DEPLOYABLE_MODEL_ID" --region $REGION --project $PROJECT_ID --format "(versionAliases)"
for MODEL_VERSION in 1 2 v1 v2 ; do
    #echodo
    echo "== Model version $MODEL_VERSION =="
    gcloud ai models describe "$CD_DEPLOYABLE_MODEL_ID@$MODEL_VERSION" --region $REGION --project $PROJECT_ID --format "(versionAliases)" | yq .versionAliases
done
#echodo gcloud ai models describe "$CD_DEPLOYABLE_MODEL_ID@2" --region $REGION --project $PROJECT_ID --format "(versionAliases)"
#echodo gcloud ai models describe "$CD_DEPLOYABLE_MODEL_ID@3" --region $REGION --project $PROJECT_ID --format "(versionAliases)"
#echodo gcloud ai models describe "california_reg_model" --region $REGION --project $PROJECT_ID --format "(versionAliases)"
#gcloud ai models describe "$CD_DEPLOYABLE_MODEL" --region $REGION --project $PROJECT_ID --format "(versionAliases)"

echo '😎 3. Lets now the ENDPOINTS:'
#gcloud ai endpoints describe demo24-prod
for DEMO_ENV in demo24-dev demo24-preprod demo24-prod ; do
    echo "== $DEMO_ENV =="
    gcloud ai endpoints describe $DEMO_ENV | tee t.endpoint.$DEMO_ENV.yaml | yq .deployedModels[0]
#end
done

#cat t.endpoint.demo24-prod.yaml | yq .deployedModels[0]
