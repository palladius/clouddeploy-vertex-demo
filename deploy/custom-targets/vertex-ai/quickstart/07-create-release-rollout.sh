#!/bin/bash

#export TMPDIR=/tmp/tmp.Fe9QrUEzpe/

set -euo pipefail

REL_NAME="release-008"

# ERROR
#{"errorCode":"CONFIG_FILE_PARSING_ERR","errorMessage":"error parsing skaffold configuration file: unable to parse config: yaml: unmarshal errors:\n  line 10: field container not found in type v4beta7.Action"}
#
# 11mar rel07: Substituting replace_vars with also dev EP..  DEV model is now 2371068237996621824 correclty https://screenshot.googleplex.com/ByaPQadtnsRLJLy
# 11mar rel06: After creating the dev-endpoint (with wrong model_id)
# 11mar rel05: fixed other stuff in configuration/ and pushing rel5 afterwards. out/ was broken so i moved it out. It would created out/configuration/ over and over. Maybe a mktmp is better :)
# 11mar rel04: moved from projects/rick-and-nardy-demo/locations/us-central1/endpoints/quickstart-prod to projects/rick-and-nardy-demo/locations/us-central1/endpoints/quickstart-dev
# 11mar rel03: pushed to dev 1st time
# 11mar -----  ricc creates dev target before prod. Super weird mutation: https://screenshot.googleplex.com/8L2yiyDY8aQ8Qpb
# 22feb rel02: same -> prod
# 22feb rel01: first one -> prod

echo "🚀 Deploying release '$REL_NAME'.."

gcloud deploy releases create "$REL_NAME" \
    --delivery-pipeline=vertex-ai-cloud-deploy-pipeline \
    --project=$PROJECT_ID \
    --region=$REGION \
    --source=$TMPDIR/configuration \
    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/test_model"

