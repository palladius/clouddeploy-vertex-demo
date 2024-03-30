## Demo Vegas24 instructions

### Setup and auth.

* `gaic` - set up  env vars. `git diff` if it fails.
* `./11-explore-models.sh` - check GCLOUD AUTH works.

### Create Endpoints and check

* `./04-create-vertexai-ep.sh`
* `./11-explore-models.sh` - check it all works. Model and 3 endpoints are there.
* Make sure no approvals are there (gray "0 pending" vs yellow "1 pending") in https://pantheon.corp.google.com/deploy/delivery-pipelines/us-central1/vertex-demo-verify?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo


### Create first release

```bash

./demo-07-create-release-for-v3.sh 1 shipping first release to dev

```



## Cleanup for next demo

* remove aliases from
