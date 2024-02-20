#!/bin/bash

set -euo pipefail

echo First make sure docker daemon is running...
# docker ps
minikube start --profile custom
skaffold config set --global local-cluster true
eval $(minikube -p custom docker-env)
