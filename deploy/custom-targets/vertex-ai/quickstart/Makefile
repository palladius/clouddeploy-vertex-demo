

auth: login
login:
	gcloud auth login
	gcloud auth application-default login

clean:
	rm -rf out/

test-model-should-fail:
	MIN_VALUE=1000 MAX_VALUE=2000 ./model-seems-ok.sh california-input.json

# but it doesnt... Ivan on it
test-model-should-succeed:
	MIN_VALUE=1 MAX_VALUE=20000 ./model-seems-ok.sh california-input.json
