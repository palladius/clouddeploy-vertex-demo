

auth: login
login:
	gcloud auth login
	gcloud auth application-default login

clean:
	rm -rf out/ .echodo_history rm _env_gaic.* out-v4-verify/

show: status
status:
	./13-show.sh


test-model-should-fail:
	MIN_VALUE=1000 MAX_VALUE=2000 ./model-seems-ok.sh california-input.json

# but it doesnt... Ivan on it
test-model-should-succeed:
	MIN_VALUE=1 MAX_VALUE=20000 ./model-seems-ok.sh california-input.json

test-verify-as-is:
	cd configuration/ && skaffold verify

test-models:
	./test-both-endpoints-locally.sh

test-verify-locally:
	echo Still unsure which of the 2 scripts I should try:
	echo '1. Testing the one used by Skaffold: /model-seems-ok.sh'
	docker run -it alpine:3.15.4 sh -c "`cat model-seems-ok.sh`"
    echo '2. Testing the one used by Ricc for testing and locally: ./demo-model-seems-ok.sh'
	docker run -it alpine:3.15.4 sh -c "`cat demo-model-seems-ok.sh`"

