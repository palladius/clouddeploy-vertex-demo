## Demo Vegas24 instructions

### Setup and auth.

* `gaic` - set up  env vars. `git diff` if it fails.
* `./11-explore-models.sh` - check GCLOUD AUTH works.

### Create Endpoints and check

* `./04-create-vertexai-ep.sh`
* `./11-explore-models.sh` - check it all works. Model and 3 endpoints are there.
* Make sure no approvals are there (gray "0 pending" vs yellow "1 pending") in https://pantheon.corp.google.com/deploy/delivery-pipelines/us-central1/vertex-demo-verify?project=rick-and-nardy-demo


### Create first release

```bash
./demo-07-create-release-for-v3.sh 1 shipping first release to dev
```

* Verify where the Model v1 is deployed: https://pantheon.corp.google.com/vertex-ai/models/locations/us-central1/models/8413639997114023936/versions/1/deploy?project=rick-and-nardy-demo
* While the v1 is deploying to dev, expect it to **progress** to preprod automatically.
* Meanwhile show the AI part of it.
* Maybe show you received an email

### Show progress on UI

* Show the approval to PROD v1
* Click "review"
* Show the diff
* do NOT click approve. Say you want to think about it.

### Check quality of the release before progressing to PROD

* Open
* First add JSON request to it: https://pantheon.corp.google.com/vertex-ai/models/locations/us-central1/models/8413639997114023936/versions/1/deploy?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo
```
{
   "instances": [[
     2.34476576,
      0.98214266,
      0.62855945,
     -0.15375759,
     -0.9744286 ,
     -0.04959654,
      1.05254828,
     -1.32783522
   ]]
 }
```
* get result , say "1.899170756340027"
* Explain this is the price in 100'000 , in this case ~`189k` USD.

### Create v2 release

```bash
./demo-07-create-release-for-v3.sh 2 Lets try Ivan new shiny release
```

* Show this in CD UI https://pantheon.corp.google.com/deploy/delivery-pipelines/us-central1/vertex-demo-verify?project=rick-and-nardy-demo
* Also shjow the change to VAI UI: https://pantheon.corp.google.com/vertex-ai/online-prediction/locations/us-central1/endpoints/demo24-dev?project=rick-and-nardy-demo

## Cleanup for next demo

* remove aliases from
