
# PROJECT_ID='rick-and-nardy-demo'
# BUCKET="gs://${PROJECT_ID}-bucket"

set -euo pipefail

gsutil mb -l us-central1 $GS_BUCKET

echodo gsutil ls  "$GS_BUCKET"
# This doesnt work as i created from a different project id and there's cross-project-id SA problems (see error below)
#OUTPUT_MODEL_DIRECTORY="gs://rick-and-nardy-demo-bucket/model_output/"
## Vertex aereror
#Unable to start training due to the following error: Service account `service-849075740253@gcp-sa-aiplatform-cc.iam.gserviceaccount.com` does not have `[storage.buckets.get, storage.objects.get, storage.objects.create]` IAM permission(s) to the bucket "rick-and-nardy-demo-bucket". Please either copy the files to the Google Cloud Storage bucket owned by your project, or grant the required IAM permission(s) to the service account.

#OUTPUT_MODEL_DIRECTORY="$GS_BUCKET/flowers_output/"
#VERTEX_TRAINING_JOB_NAME='flowers-try2'

# Gemini says:
# gcloud projects add-iam-policy-binding rick-and-nardy-demo \
#     --member='serviceAccount:service-849075740253@gcp-sa-aiplatform-cc.iam.gserviceaccount.com' \
#     --role='roles/storage.objectAdmin'
