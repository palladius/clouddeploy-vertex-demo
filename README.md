# clouddeploy-vertex-demo

Self: https://github.com/palladius/clouddeploy-vertex-demo

This demo aims at pleonastically demonstrate how Cloud Deploy can be utilized to deploy a Vertex AI "moving target" model. This should be showcases in Vegas in April 2024.


## Ideas

* More info: go/ricc-inardini
* Create two CD configs: 1 quick n dirty (STAG+PROD) and 1 proper (DEV for Cloud Build to pass, then STAG then button to PROD).

## High level idea

* Build on Cloud Deploy what yesterday was only available with Cloud Build.
* Make multi-stage (multi-env) Model deployment on Vertex AI backed by the power of CD.
* [optional] Make PROD to deploy to a new PROD project id.
* [optional] Do the same with terraform.

Ivan idea:

* model: https://www.kaggle.com/c/boston-housing

some additioanl models (thanks umount@):

* https://www.kaggle.com/datasets/arshid/iris-flower-dataset
* https://www.kaggle.com/datasets/lakshmi25npathi/imdb-dataset-of-50k-movie-reviews
* https://openml.org/search?type=data&sort=nr_of_likes&status=active&id=554 mnist_784
* https://openml.org/search?type=data&sort=nr_of_likes&status=active&id=40945 Titanic
* https://openml.org/search?type=data&sort=nr_of_likes&status=active&id=40498 Wine quality white
