#!/bin/bash

# "67" stands for script 06 + script 07. I know, genius!

set -euo pipefail

#############################################
# Script 06 - adapted
#############################################

#TMPDIR = "out/"
export TMPDIR_IVAN="out-ivan67/"

mkdir -p "${TMPDIR_IVAN}"

echo "0. Vars:"
echo "+ CD_DEPLOYABLE_MODEL: $CD_DEPLOYABLE_MODEL"

echo "1. Replacing vars in this dir: $TMPDIR_IVAN"
./replace_variables.sh -p $PROJECT_ID -r $REGION -e $ENDPOINT_ID -t $TMPDIR_IVAN -d $DEV_ENDPOINT_ID

echo 2. Lets now apply CD config..
gcloud deploy apply --file=$TMPDIR_IVAN/clouddeploy.yaml --project=$PROJECT_ID --region=$REGION

#############################################
# Script 07 - adapted
#############################################

#############################################
# Release name
REL_NAME_BASE="017"
# crated demo-dev e demo-prod
# 12mar v016 after lunch. maybe it helps. Also Ivan pinned a version.
# 12mar v015 added CD_DEPLOYABLE_MODELto gaic and piggybacked in all scripts
# 12mar v014 direnv allow
# 12mar v013 fixed TMPDIR_IVAN in script 7 below.
# 12mar v012 First test using Ivan Pipeline (PIPELINE_NAME)
# Starting from 12 since 11

REL_NAME="rel-ivan-${REL_NAME_BASE}"
echo "🚀 3. Deploying release '$REL_NAME'.. to model '$CD_DEPLOYABLE_MODEL'.."
#    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/test_model"
# vertex-ai-cloud-deploy-pipeline
gcloud deploy releases create "$REL_NAME" \
    --delivery-pipeline=$VAI_PIPELINE \
    --project=$PROJECT_ID \
    --region=$REGION \
    --source=$TMPDIR_IVAN/configuration \
    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/$CD_DEPLOYABLE_MODEL"

echo "😍 All good."
