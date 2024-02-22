
PROJECT_ID = "rick-and-nardy-demo"

deploy-apply:
	gcloud deploy apply --file=clouddeploy.yaml --region=us-central1 --project=$(PROJECT_ID)


create-release:
	gcloud deploy releases create test-release-001 \
		--project=$(PROJECT_ID) \
		--region=us-central1 \
		--delivery-pipeline=ricc-custom-targets-pipeline

create-release2:
	gcloud deploy releases create test-release-002 \
		--project=$(PROJECT_ID) \
		--region=us-central1 \
		--delivery-pipeline=ricc-custom-targets-pipeline
