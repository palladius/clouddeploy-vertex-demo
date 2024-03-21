#!/bin/bash

# full status:
# gcloud deploy releases describe release-001 --delivery-pipeline=vertex-ai-cloud-deploy-pipeline --project=$PROJECT_ID --region=$REGION

for RELEASE in release-001 release-002 release-003 ; do
    echo -en "🎃 Status for $RELEASE: "
    gcloud deploy releases describe "$RELEASE" --delivery-pipeline=$VAI_PIPELINE --project=$PROJECT_ID --region=$REGION --format "(renderState)"
done

# echo '😎 Now Inspecting aliases in the deployed model:'
# gcloud ai endpoints describe $ENDPOINT_ID --region $REGION --project $PROJECT_ID
