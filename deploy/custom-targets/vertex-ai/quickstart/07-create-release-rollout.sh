#!/bin/bash

#export TMPDIR=/tmp/tmp.Fe9QrUEzpe/

set -euo pipefail

REL_NAME="release-011"
REL_DESCRIPTION="Trying descriptions now.."
# ok wuith rel11 moving back to normal one...
# rel11 15mar Trying descriptions now..
# rel10b: same as above, but I changed pipeline to an entirely NEW one.
# rel10: recreating a NEW empty pipeline. maybe it doesnt work with old one. Fixed by copying the skaffold (broken)
#        directly from https://github.com/GoogleCloudPlatform/cloud-deploy-samples/blob/main/custom-targets/vertex-ai/quickstart/configuration/skaffold.yaml
# {"errorCode":"CONFIG_FILE_PARSING_ERR","errorMessage":"error parsing skaffold configuration file: unable to parse config: yaml: unmarshal errors:\n  line 9: field container not found in type v4beta7.VerifyContainer"}
# 11mar rel09: rm -rf out/, exec 06 and 07 scripts.. im SURE i fixed skaffold!
# 🚨 Same ERROR -> I'll relaunch wiht 06 and 07 scripts and also remove out/
# 11mar rel07: Fixing skaffold (note i reversed 8 and 7)
# ERROR # #{"errorCode":"CONFIG_FILE_PARSING_ERR","errorMessage":"error parsing skaffold configuration file: unable to parse config: yaml: unmarshal errors:\n  line 10: field container not found in type v4beta7.Action"}
# 11mar rel08: Substituting replace_vars with also dev EP..  DEV model is now 2371068237996621824 correclty https://screenshot.googleplex.com/ByaPQadtnsRLJLy
# 11mar rel06: After creating the dev-endpoint (with wrong model_id)
# 11mar rel05: fixed other stuff in configuration/ and pushing rel5 afterwards. out/ was broken so i moved it out. It would created out/configuration/ over and over. Maybe a mktmp is better :)
# 11mar rel04: moved from projects/rick-and-nardy-demo/locations/us-central1/endpoints/quickstart-prod to projects/rick-and-nardy-demo/locations/us-central1/endpoints/quickstart-dev
# 11mar rel03: pushed to dev 1st time
# 11mar -----  ricc creates dev target before prod. Super weird mutation: https://screenshot.googleplex.com/8L2yiyDY8aQ8Qpb
# 22feb rel02: same -> prod
# 22feb rel01: first one -> prod

echo "🚀 Deploying release '$REL_NAME'.."
# vertex-ai-cloud-deploy-pipeline
gcloud deploy releases create "$REL_NAME" \
    --delivery-pipeline=$VAI_PIPELINE \
    --description="[👷Rel07] $REL_DESCRIPTION" \
    --project=$PROJECT_ID \
    --region=$REGION \
    --source=$TMPDIR/configuration \
    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/$CD_DEPLOYABLE_MODEL"

