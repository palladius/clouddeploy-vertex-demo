

plan:
	TF_VAR_project_id='rick-and-nardy-demo' terraform plan
# -input=false -out=tfplan

apply:
# -auto-approve
	TF_VAR_project_id='rick-and-nardy-demo' TF_VAR_region='us-central1' terraform apply -input=false -auto-approve

destroy:
	terraform destroy

refresh:
# this is equivalent to TF refresh: https://developer.hashicorp.com/terraform/cli/commands/refresh
	terraform apply -refresh-only -auto-approve

login:
# this is for TF
	gcloud auth application-default login
# this is for you
	gcloud auth login

tf-show:
	gsutil ls -al gs://rick-and-nardy-tfstate/terraform/state/
#	gsutil ls -alL gs://rick-and-nardy-tfstate/terraform/state/

