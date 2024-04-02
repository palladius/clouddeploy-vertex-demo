## Demo Vegas24 instructions

Self: https://github.com/palladius/clouddeploy-vertex-demo/blob/main/deploy/custom-targets/vertex-ai/quickstart-v2-verify/DEMO_VEGAS.md

## Recording Setup

* Linux (derek): _ctrl-space_ +  Record -> "Take a screenshot"  (screencast recorder)
    * Goes into derek:~/Videos/Screencasts
* Mac: `Camtasia`
* Chromebook / Chrome: **internal** chromext ("Screencast").

Tips :
* Make sure you dont show the URL and the CTRL SHIFT B below it.
* start with some things open:
    1. Slides
    2. PSA doc
    3. CD - pipeline: https://pantheon.corp.google.com/deploy/delivery-pipelines/us-central1/vertex-demo-verify?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo
    4. Model registry (model view): https://pantheon.corp.google.com/vertex-ai/models?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo
    5. Online predictions (Endpoints view): https://pantheon.corp.google.com/vertex-ai/online-prediction/endpoints?project=rick-and-nardy-demo&e=-13802955&mods=logs_tg_staging
    6. Price trix - emptied: https://docs.google.com/spreadsheets/d/17emmad7-UAUL298z-pYBWD76NWbFSmkphnpwSguZFTI/edit?resourcekey=0-ffn4eeakYSpU0QYRancZag#gid=2075780709

### Setup and auth (make sure you have access)

* `gaic` - set up  env vars. `git diff` if it fails.
* `./11-explore-models.sh` - check GCLOUD AUTH works.

### Pre-deployment Cleanup

1. remove ALIASES from all VERSIONS: https://pantheon.corp.google.com/vertex-ai/models/locations/us-central1/models/8413639997114023936?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo
    1. 3 dots on v1 side.
    2. 1. click `edit alias`
    3. remove everything except v1 or v2
    4. Same on v2 side (3 dots, ...)

  https://pantheon.corp.google.com/vertex-ai/online-prediction/locations/us-central1/endpoints/demo24-dev?project=rick-and-nardy-demo

  forse trovi meglio TODO

1. NO! DO NOT UNDEPLOY EPs.

* Check ALL VERSIONS link: https://pantheon.corp.google.com/vertex-ai/models/locations/us-central1/models/8413639997114023936?project=rick-and-nardy-demo


1. Make sure v1 is NOT deployed. You want to deploy a v1 first. For instance check :
    1. https://pantheon.corp.google.com/deploy/delivery-pipelines/us-central1/vertex-demo-verify?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo that all 3 endpoints are on v2. https://screenshot.googleplex.com/tGrgcFiJfkpuHjt

**IMPORTANT** Actually if you undeploy them it takes A LONG TIME! 5-6 minutes or more. So maybe worth NOT undeploying but make sure they deploy to v2.

### [OPTIONAL] Create Endpoints and check

Only run if you dont see the 3 endpoinst.

* `./04-create-vertexai-ep.sh`
* `./11-explore-models.sh` - check it all works. Model and 3 endpoints are there.
* Make sure no approvals are there (gray "0 pending" vs yellow "1 pending") in https://pantheon.corp.google.com/deploy/delivery-pipelines/us-central1/vertex-demo-verify?project=rick-and-nardy-demo


### Create first release

* Show slide 54 and 55 (create release theory and script)
* Now show the CLI

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
* write this down on the easy trix: https://docs.google.com/spreadsheets/d/17emmad7-UAUL298z-pYBWD76NWbFSmkphnpwSguZFTI/edit
* color it yellow for v1 / green for v2. TODO: make auto coloring.

### Create v2 release

```bash
./demo-07-create-release-for-v3.sh 2 Lets try Ivan new shiny release
```

* Show this in CD UI https://pantheon.corp.google.com/deploy/delivery-pipelines/us-central1/vertex-demo-verify?project=rick-and-nardy-demo
* Also shjow the change to VAI UI: https://pantheon.corp.google.com/vertex-ai/online-prediction/locations/us-central1/endpoints/demo24-dev?project=rick-and-nardy-demo
* BINGO! https://screenshot.googleplex.com/4EeUZyevb8WTbwq


Now call the script:

* `./demo-model-seems-ok.sh`
* Price of the house for this model is 0.7?


### Check quality of v2 vs v1

* Paste the same above JSON in the v2 prediction and tell that the v2 number is be5tter or worse according to what Ivan says.
* Now show that you have from UI (nicer):
* v2 in demo-dev: https://pantheon.corp.google.com/vertex-ai/online-prediction/locations/us-central1/endpoints/demo24-dev?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo
    *  Value for v2: `3.07460880279541`.
    *  Estd House price is `307k`.
* v1 in demo-prod: https://pantheon.corp.google.com/vertex-ai/models/locations/us-central1/models/8413639997114023936/versions/1/deploy?project=rick-and-nardy-demo
    *  Value for v1: `1.899170756340027`.
    *  Estd House price is `189k`.
* demo-preprod somewhere in between.

#### Alternative: use CLI

  * [OLD] `CORRECT_ENDPOINT_ID=demo24-dev ./demo-model-seems-ok.sh`  # yields 84k
  * [OLD] `CORRECT_ENDPOINT_ID=demo24-prod ./demo-model-seems-ok.sh` # yields 48k
  * Or better
  * `./test-both-endpoints-locally.sh`

Ask Ivan if the value is ok. If he's ok, then click approve.

#### Ivan says yes - approve v2 to prod

* Show the Manifest diff.
* Show it only changes @v1 vs @v2
* hit approve
* DONE!

## Cleanup for next demo

* remove aliases manually from the deployed models:
* remove aliases via pythin script: TODO (not available in gcloud)

## Appendix

Values from various 4 models from Ivan (only 1 and 2 are demonstrayed)

```JSON
v1:
{
 "predictions": [
   1.899170756340027
 ],
 "deployedModelId": "4021553938544197632",
 "model": "projects/849075740253/locations/us-central1/models/8413639997114023936",
 "modelDisplayName": "california_reg_model",
 "modelVersionId": "1"
}

v2:

{
 "predictions": [
   3.07460880279541
 ],
 "deployedModelId": "6246754366930288640",
 "model": "projects/849075740253/locations/us-central1/models/8413639997114023936",
 "modelDisplayName": "california_reg_model",
 "modelVersionId": "2"
}

v3:
{
 "predictions": [
   3.07460880279541
 ],
 "deployedModelId": "1630142536410464256",
 "model": "projects/849075740253/locations/us-central1/models/8413639997114023936",
 "modelDisplayName": "california_reg_model",
 "modelVersionId": "3"
}

v4:
{
 "predictions": [
   3.07460880279541
 ],
 "deployedModelId": "7275404669319380992",
 "model": "projects/849075740253/locations/us-central1/models/8413639997114023936",
 "modelDisplayName": "california_reg_model",
 "modelVersionId": "4"
}

```




# Takes

# Take 1

See doc

# Take 2

* pause from 1m50 to XXm??
* damn going to the toilet interrupted the recording, i need to re-do it
* But I learn that if i delete the EPs it takes 11m09s to restore: https://screenshot.googleplex.com/7XmSNZKEEMULLdj
* with existing one it takes ~3m40s https://screenshot.googleplex.com/oriNRb9S7N7PCYs
