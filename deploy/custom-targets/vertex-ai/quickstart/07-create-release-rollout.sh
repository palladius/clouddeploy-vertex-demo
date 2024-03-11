#!/bin/bash

#export TMPDIR=/tmp/tmp.Fe9QrUEzpe/

set -euo pipefail

# 11mar rel05: fixed other stuff in configuration/ and pushing rel5 afterwards. out/ was broken so i moved it out. It would created out/configuration/ over and over. Maybe a mktmp is better :)
# 11mar rel04: moved from projects/rick-and-nardy-demo/locations/us-central1/endpoints/quickstart-prod to projects/rick-and-nardy-demo/locations/us-central1/endpoints/quickstart-dev
# 11mar rel03: pushed to dev 1st time
# 11mar -----  ricc creates dev target before prod. Super weird mutation: https://screenshot.googleplex.com/8L2yiyDY8aQ8Qpb
# 22feb rel02: same -> prod
# 22feb rel01: first one -> prod

gcloud deploy releases create release-005 \
    --delivery-pipeline=vertex-ai-cloud-deploy-pipeline \
    --project=$PROJECT_ID \
    --region=$REGION \
    --source=$TMPDIR/configuration \
    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/test_model"
