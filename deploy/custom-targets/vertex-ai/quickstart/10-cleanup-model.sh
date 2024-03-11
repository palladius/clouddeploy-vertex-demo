#!/bin/bash

echo 'Are you sure? Naah I wont let you. See commented code anyhow if you REALLY want to do it.'
#sleep 5


DEPLOYED_MODEL_ID=$(gcloud ai endpoints describe $ENDPOINT_ID --region $REGION --project $PROJECT_ID --format "(deployedModels[0].id)" | yq '.deployedModels[0].id' )

echo "Execute this: gcloud ai endpoints undeploy-model $ENDPOINT_ID --region $REGION --project $PROJECT_ID --deployed-model-id $DEPLOYED_MODEL_ID"

# gcloud ai endpoints delete $ENDPOINT_ID --region $REGION --project $PROJECT_ID
# gcloud ai models delete test_model --region $REGION --project $PROJECT_ID
# gcloud deploy delete --file=$TMPDIR/clouddeploy.yaml --force --project=$PROJECT_ID --region=$REGION
