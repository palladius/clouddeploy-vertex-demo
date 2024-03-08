"""I've seen hwo to do it via UI. Lets now see via code.

https://codelabs.developers.google.com/vertex-p2p-training#5

The previous section showed how to launch the training job via the UI. In this section, you'll see an alternative way to submit the training job by using the Vertex AI Python SDK.

"""

from google.cloud import aiplatform
#import _env_gaic
from _env_gaic import *  # Import all the variables

print(PROJECT_ID)  # Access the imported variables
print(GS_BUCKET)
print(BUCKET_NAME)
print(IMAGE_URI)
print(OUTPUT_MODEL_DIRECTORY) # gs://rick-and-nardy-demo-flower-bucket/flowers_output/
#exit(42)

my_job = aiplatform.CustomContainerTrainingJob(
    display_name="flowers-v3b-with-python-sdk-job",
    #container_uri=f"us-central1-docker.pkg.dev/{PROJECT_ID}/flower-app/flower_image:latest",
    container_uri=IMAGE_URI,
    staging_bucket="gs://rick-and-nardy-demo-flower-bucket/flowers_output_v3b/")

# staging_bucket=f"gs://{BUCKET}")

my_job.run(replica_count=1,
           machine_type='n1-standard-8',
           accelerator_type='NVIDIA_TESLA_V100',
           accelerator_count=1)


# Training Output directory: gs://your-bucket-name-rick-and-nardy-demo-unique/flowers_output/aiplatform-custom-training-2024-03-08-12:16:44.435
# View Training: https://console.cloud.google.com/ai/platform/locations/us-central1/training/389195161676021760?project=849075740253
# View backing custom job: https://console.cloud.google.com/ai/platform/locations/us-central1/training/8584919650746236928?project=849075740253
