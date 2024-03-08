
* https://codelabs.developers.google.com/vertex-p2p-predictions?hl=en#0
* tells me to do this first
* https://codelabs.developers.google.com/vertex-p2p-training#0


So

1. https://codelabs.developers.google.com/vertex-p2p-training#0
2. https://codelabs.developers.google.com/vertex-p2p-predictions?hl=en#0


## 1 https://codelabs.developers.google.com/vertex-p2p-training

### 3. Set up env

project id: rick-and-nardy-demo
* https://pantheon.corp.google.com/vertex-ai/workbench/locations/europe-west6-a/user-managed/tensorflow-2-11-20240307-140338?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo

done (yesterday)

### 4. containerize code

```
PROJECT_ID='rick-and-nardy-demo'
BUCKET="gs://${PROJECT_ID}-bucket"
gsutil mb -l us-central1 $BUCKET
```
