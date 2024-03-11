

## Explaination of the dirs

* `custom-targets/`: CT. Many of subfolders copied from https://github.com/GoogleCloudPlatform/cloud-deploy-samples/tree/main/custom-targets/
  * `cloud-deploy-samples`  Makefile  README.md
  * `terraform`. Copied from .../terraform
  * `test-ricc/`.   Created by ricc on feb22. Creates:
    * **Pipeline**: `ricc-custom-targets-pipeline` # was custom-targets-pipeline
    * **Targets**:
      * `sample-env`
    * **Purpose**: demonstrate just a sample pipeline (does nothing really).
  * `util`. Copied from .../util Contains common code for all deployers to work
  * `vertex-ai`. Copied from .../vertex-ai
    * `model-deployer/`: (included in original repo). Contains `go` code for deploying and rendering to Vertex AI. Untouched
    * `quickstart/`: (included in original repo). Ricc added PLENTY of stuff. Mostly done on Feb22.
      * **Pipeline**:
      * **Targets**:
        * `prod-endpoint`
      * **Purpose**:
      * Additional code: Ricc added lot of IaC shell scripts. Config in `.envrc`
    * `ricc-model-tester/`: Created by 💛 Ricc.
* `verify-evaluate-cloud-metrics`: Learning about Verification.
