#!/bin/bash

set -euo pipefail

echo "Uploading CD_BOSTON_MODEL: $CD_BOSTON_MODEL"

# https://screenshot.googleplex.com/5tXKcQZ7ssDHKab
# See other brothers of Boston: gsutil ls gs://cloud-samples-data/vertex-ai/model-deployment/models

gcloud ai models upload \
    --artifact-uri gs://cloud-samples-data/vertex-ai/model-deployment/models/boston/model \
    --display-name=test-model \
    --container-image-uri=us-docker.pkg.dev/vertex-ai-restricted/prediction/tf_opt-cpu.nightly:latest \
    --project="$PROJECT_ID" \
    --region="$REGION" \
    --model-id="$CD_BOSTON_MODEL"

# Note: $CD_DEPLOYABLE_MODEL is from Ivan
# CD_BOSTON_MODEL: test_model
