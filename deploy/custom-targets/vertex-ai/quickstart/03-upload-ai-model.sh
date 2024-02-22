
gcloud ai models upload \
    --artifact-uri gs://cloud-samples-data/vertex-ai/model-deployment/models/boston/model \
    --display-name=test-model \
    --container-image-uri=us-docker.pkg.dev/vertex-ai-restricted/prediction/tf_opt-cpu.nightly:latest \
    --project=$PROJECT_ID \
    --region=$REGION \
    --model-id=test_model

