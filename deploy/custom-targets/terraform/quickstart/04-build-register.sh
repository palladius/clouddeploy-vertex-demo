#!/bin/bash

set -euo pipefail

# fails if var not set so were good.
echo DEV_BACKEND_BUCKET: $DEV_BACKEND_BUCKET

../build_and_register.sh -p $PROJECT_ID -r $REGION
