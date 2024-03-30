
#!/bin/bash

set -euo pipefail

function _title() {
    echo -en "\033[1;33m 🟡 $*\033[0m\n"
}

_title "1. Models in dflt region:"
gcloud ai models list 2>/dev/null
# Using endpoint [https://us-central1-aiplatform.googleapis.com/]
# MODEL_ID             DISPLAY_NAME
# 977000743674314752   test-model
# 3485927948584747008  california_reg_model

_title "2. Lets double click on Ivan model for Endpoints and Versions: $CD_DEPLOYABLE_MODEL_ID"
gcloud ai models describe "$CD_DEPLOYABLE_MODEL_ID" 2>/dev/null > t.model
echo '2A. Endpoints:'
    cat t.model | yq .deployedModels
echo '2B. Version Aliases:'
    cat t.model | yq .versionAliases

_title '3. Lets now see the endpoints available:'
gcloud ai endpoints list 2>/dev/null
