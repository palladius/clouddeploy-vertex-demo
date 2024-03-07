export REGION="us-central1"
export PROJECT_ID=$(gcloud config list --format 'value(core.project)')
export BUCKET_NAME="${PROJECT_ID}-bucket"
