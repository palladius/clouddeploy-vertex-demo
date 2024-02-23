

app-dev:
	cd apps/buildpacks-node && skaffold dev

# app-build:
# 	cd apps/buildpacks-node && skaffold build

# app-deploy:
# 	cd apps/buildpacks-node && skaffold run

minikube-stop:
	minikube delete -p minikube

minikube-start:
	bin/minikube-start.sh

tf-show:
	gsutil ls -alL gs://rick-and-nardy-tfstate/terraform/state/

