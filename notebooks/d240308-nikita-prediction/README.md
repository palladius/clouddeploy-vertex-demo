
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

... moved everything into .gcloudconfig.yaml

now it all works after 3 tries. Lets move on to GEtting predictions!

## 2 https://codelabs.developers.google.com/vertex-p2p-predictions?hl=en#0

Lets update to model registry.



## and it works!

I can run the predict script with a file in `images/` and it returns the probability:

![Image of the tulip](images/bulbi-di-tulipano-fiamma-128.png)


```
🐼 ./ex2-02interrogate-model.py
🐈𓂀🦁 Prediction for file images/bulbi-di-tulipano-fiamma-128.png: [[1.01279773e-09, 1.05273939e-05, 0.00660999911, 0.0412245356, 0.952154934]]
The sphinx has spoken -> tulip (probability: 95.2154934%)
```

In this case, it says `images/bulbi-di-tulipano-fiamma-128.png` has a 95.2% prob of being a tulip. Well done!
