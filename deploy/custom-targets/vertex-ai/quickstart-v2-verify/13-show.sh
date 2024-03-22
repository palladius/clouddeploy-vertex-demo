#!/bin/bash

# todo use ENV instead

function _cleanup_output() {
    echo "[💻] \$ $*"
    "$@" 2>&1 | egrep -v "Using endpoint"
}

echo "🧠 Vertex Models:"
_cleanup_output gcloud ai models list-version 8413639997114023936 # 2>&1 | egrep -v "Using end"
echo "🧠 Vertex Endpoints:"
_cleanup_output gcloud ai endpoints list

# Gemini:
gcloud ai models list-version 8413639997114023936  --format json | jq '.[] |
{
  endpoint: .deployedModels[].endpoint,
  versionAliases: .versionAliases
}
'
