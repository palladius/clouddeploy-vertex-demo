#!/usr/bin/env python

'''Page5 in https://codelabs.developers.google.com/vertex-p2p-predictions?hl=en#4
'''
from google.cloud import aiplatform
from _env_gaic import *  # Import all the variables

print(PROJECT_ID)  # Access the imported variables
print(GS_BUCKET)
print(BUCKET_NAME)
print(IMAGE_URI)
print(OUTPUT_MODEL_DIRECTORY) # gs://rick-and-nardy-demo-flower-bucket/flowers_output/
print(OUTPUT_MODEL_DIRECTORY_V3) # gs://rick-and-nardy-demo-flower-bucket/flowers_output/
print(PROJECT_NUMBER) # gs://rick-and-nardy-demo-flower-bucket/flowers_output/
print(EX2_MODEL_ID)
#exit(42)

model_upload = True
model_deploy = True

ModelName = 'flower-model-v3-ricc-pysdk-bifidus'

if model_upload:
    my_model = aiplatform.Model.upload(
        display_name=ModelName,
        artifact_uri=OUTPUT_MODEL_DIRECTORY_V3, # 'gs://{PROJECT_ID}-bucket/model_output',
        serving_container_image_uri='us-docker.pkg.dev/vertex-ai/prediction/tf2-cpu.2-8:latest',
        labels={
            'creation-via': 'ui',
            'github-repo-user': 'palladius',
            'github-repo-name': 'clouddeploy-vertex-demo',
            'dataset': 'nikita-flowers',
            'env': 'dev',
        }
        )

# it works!!!

# Creating Model
# Create Model backing LRO: projects/849075740253/locations/us-central1/models/8596246888255062016/operations/1775381459729645568
# Model created. Resource name: projects/849075740253/locations/us-central1/models/8596246888255062016@1
# To use this Model in another session:
# model = aiplatform.Model('projects/849075740253/locations/us-central1/models/8596246888255062016@1')


#exit(42)

# TODO https://codelabs.developers.google.com/vertex-p2p-predictions?hl=en#4
if model_deploy:
    #model_id = 3738551740182560768
    model_id = my_model.name
    #TODO ricc-  find model_id, probably evben with a gcloud command.
    # or maybe via my_model.id
    # >>> my_model.name
    # => '944631121352589312'
    model_config_str = f"projects/{PROJECT_NUMBER}/locations/us-central1/models/{model_id}"
    print(f"model_config_str config: {model_config_str}")
    my_model = aiplatform.Model(model_config_str)
    #my_model = aiplatform.Model(f"projects/{PROJECT_NUMBER}/locations/us-central1/models/{ModelName}")
    print(f"my_model.name: {my_model.name}")
    endpoint = my_model.deploy(
        deployed_model_display_name='my-endpoint',
        traffic_split={"0": 100},
        machine_type="n1-standard-4",
        accelerator_count=0,
        min_replica_count=1,
        max_replica_count=1,
    )
