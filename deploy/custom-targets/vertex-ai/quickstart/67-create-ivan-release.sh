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
echo "+ TMPDIR_IVAN: $TMPDIR_IVAN"
echo "+ PROD_DEMO_ENDPOINT_ID: $PROD_DEMO_ENDPOINT_ID"
echo "+ DEV_DEMO_ENDPOINT_ID: $DEV_DEMO_ENDPOINT_ID"
echo "+ CD_DEPLOYABLE_MODEL: $CD_DEPLOYABLE_MODEL"
echo "+ CD_DEPLOYABLE_MODEL_ID: $CD_DEPLOYABLE_MODEL_ID"



echo "1. Replacing vars in this dir: $TMPDIR_IVAN"

# Normal test version
#./replace_variables.sh -p $PROJECT_ID -r $REGION -e $ENDPOINT_ID -t $TMPDIR_IVAN -d $DEV_ENDPOINT_ID
# Demo version
#PROD_DEMO_ENDPOINT_ID="demo-prod"
#DEV_DEMO_ENDPOINT_ID="demo-dev"
# demo-dev     dev-endpoint
#demo-prod    prod-endpoint
#PROD_DEMO_ENDPOINT_NAME="prod-endpoint"
#DEV_DEMO_ENDPOINT_NAME="dev-endpoint"
#./replace_variables.sh -p $PROJECT_ID -r $REGION -e $PROD_DEMO_ENDPOINT_NAME -t $TMPDIR_IVAN -d $DEV_DEMO_ENDPOINT_NAME
./replace_variables.sh -p $PROJECT_ID -r $REGION -e $PROD_DEMO_ENDPOINT_ID -t $TMPDIR_IVAN -d $DEV_DEMO_ENDPOINT_ID

echo 2. Lets now apply CD config..
gcloud deploy apply --file=$TMPDIR_IVAN/clouddeploy.yaml --project=$PROJECT_ID --region=$REGION

#############################################
# Script 07 - adapted
#############################################

#############################################
# Release name
REL_NAME_BASE="022"
# 12mar v022 Now just testing some changes in the parasms, here i moved these 2:
#               customTarget/vertexAIMinReplicaCount: "2" (from 1)
#               customTarget/vertexAIAliases: "demo24-dev,testme" (from dev,testme)
# 12mar v021 i think i found the issue, i need to use the ID (number), not the string (in fact there are TWO `california_reg_model`). See script 09.
#            The problem was ismply i had to use CD_DEPLOYABLE_MODEL_ID instead of CD_DEPLOYABLE_MODEL since Ivan gave me ugly name (big number buridone)
# 12mar v020 new naming. stil nada.
# 12mar v019 I have a feeling i never sent the 17 but sent the 16 twice. So there you go, trying again 19 with IDS.
# 12mar v018 using name instead
# 12mar v017 -> with ids.
# 12mar v016 created `demo-dev` e `demo-prod` and using those. if it doesnt work using the other names.
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
    --deploy-parameters="customTarget/vertexAIModel=projects/$PROJECT_ID/locations/$REGION/models/$CD_DEPLOYABLE_MODEL_ID"

echo "😍 All good."
echo "🚀 Deployed release '$REL_NAME'.. to model '$CD_DEPLOYABLE_MODEL'.."
