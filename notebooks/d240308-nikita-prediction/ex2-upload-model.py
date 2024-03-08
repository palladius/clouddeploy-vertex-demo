

from google.cloud import aiplatform
from _env_gaic import *  # Import all the variables

print(PROJECT_ID)  # Access the imported variables
print(GS_BUCKET)
print(BUCKET_NAME)
print(IMAGE_URI)
print(OUTPUT_MODEL_DIRECTORY) # gs://rick-and-nardy-demo-flower-bucket/flowers_output/
print(OUTPUT_MODEL_DIRECTORY_V3) # gs://rick-and-nardy-demo-flower-bucket/flowers_output/
#exit(42)

my_model = aiplatform.Model.upload(
    display_name='flower-model-v3-ricc-pysdk',
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
