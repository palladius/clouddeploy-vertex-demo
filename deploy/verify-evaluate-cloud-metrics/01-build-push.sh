
# https://github.com/GoogleCloudPlatform/cloud-deploy-samples/blob/main/verify-evaluate-cloud-metrics/README.md

# https://pantheon.corp.google.com/artifacts/docker/rick-and-nardy-demo/us-central1/ricc-verify-demo?project=rick-and-nardy-demo
AR_REPO_VERIFY="us-central1-docker.pkg.dev/rick-and-nardy-demo/ricc-verify-demo"
IMAGE_VERIFY='us-central1-docker.pkg.dev/rick-and-nardy-demo/ricc-verify-demo/ricc-verify-test'

docker build . -t "$IMAGE_VERIFY"
docker push "$IMAGE_VERIFY"
