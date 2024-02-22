#!/bin/bash

#export ENDPOINT_ID="quickstart-prod"

gcloud ai endpoints create --display-name prod-endpoint --endpoint-id "$ENDPOINT_ID" --region "$REGION" --project "$PROJECT_ID"
