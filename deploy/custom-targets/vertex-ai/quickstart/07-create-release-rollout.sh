
export TMPDIR=/tmp/tmp.Fe9QrUEzpe/

gcloud deploy releases create release-001 \
    --delivery-pipeline=vertex-ai-cloud-deploy-pipeline \
    --project=$PROJECT_ID \
    --region=$REGION \
    --source=$TMPDIR/configuration \
    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/test_model"
