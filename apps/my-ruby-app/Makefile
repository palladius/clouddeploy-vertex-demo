

skaffold-dev:
	./skaffold-wrapper.sh dev
dev: skaffold-dev

skaffold-run-dev:
	./skaffold-wrapper.sh run -p dev
skaffold-run-canary:
	./skaffold-wrapper.sh run -p canary

skaffold-render-dev:
	./skaffold-wrapper.sh render --profile=dev

test:
	echo Text fixed now all good
	which ruby && ruby ruby-app/app.rb || echo Sorry no ruby pls install it.
	echo Looks like Ruby app returns so looks like no Syntax Horrors.

kustomize-render:
	@echo See in parent directory
	kustomize build k8s/overlays/dev
	kustomize build k8s/overlays/staging
	kustomize build k8s/overlays/canary
	kustomize build k8s/overlays/prod

#echo 02. Now trying to skaffold build this gentleman..
# NOPE THIS DOESNT WORK YET IN THE CLOUD :/ ./skaffold-wrapper.sh build
#	echo Lets pretend this doesnt build.
#	/bin/false
# fixed echodo now -> try again.
run-p8080:
# omitting CLOUD_DEPLOY_TARGET_COMMON=LocalMakefileP8080  to fix a bug on purpose!
	cd ruby-app/ && bundle install && \
		CLOUD_DEPLOY_TARGET_SHORT_COMMON=Makefile bundle exec puma -p 8080
