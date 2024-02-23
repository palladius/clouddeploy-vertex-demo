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
