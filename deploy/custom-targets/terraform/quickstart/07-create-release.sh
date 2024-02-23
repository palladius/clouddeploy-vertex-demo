


gcloud deploy releases create release-001 --delivery-pipeline=tf-network-pipeline --project=$PROJECT_ID --region=$REGION --source=configuration --deploy-parameters="customTarget/tfEnableRenderPlan=true"

