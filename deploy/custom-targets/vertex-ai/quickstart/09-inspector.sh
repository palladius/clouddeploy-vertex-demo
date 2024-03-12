#!/bin/bash

echo '😎 Now Inspecting aliases in the deployed model:'
gcloud ai endpoints describe $ENDPOINT_ID --region $REGION --project $PROJECT_ID

echo '😎 Lets now see if aliases are assigned:'
gcloud ai models describe $CD_DEPLOYABLE_MODEL --region $REGION --project $PROJECT_ID --format "(versionAliases)"
