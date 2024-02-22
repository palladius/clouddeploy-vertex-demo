

plan:
	TF_VAR_project_id='rick-and-nardy-demo' terraform plan # -input=false -out=tfplan

apply:
# -auto-approve
	TF_VAR_project_id='rick-and-nardy-demo' TF_VAR_region='us-central1' terraform apply -input=false -auto-approve

destroy:
	terraform destroy

login:
	gcloud auth application-default login
