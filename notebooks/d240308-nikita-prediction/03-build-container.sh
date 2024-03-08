#!/bin/bash

#PROJECT_ID='rick-and-nardy-demo'
#REPO_NAME='flower-app'

set -euo pipefail

#IMAGE_URI=us-central1-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/flower_image:latest


gcloud artifacts repositories create $REPO_NAME --repository-format=docker \
    --location=us-central1 --description="Docker repository"

gcloud auth configure-docker \
    us-central1-docker.pkg.dev

docker build flowers/ -t $IMAGE_URI

docker push $IMAGE_URI
