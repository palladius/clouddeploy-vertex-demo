
from google.cloud import aiplatform
# import aiplatform

import os

PROJECT = os.getenv("PROJECT_ID")
# Initialize the Vertex AI client
aiplatform.init(project=PROJECT)

# Example: Create a training job
job = aiplatform.CustomJob(
    display_name="my-training-job2",
    staging_bucket='gs://your-bucket-name-rick-and-nardy-demo-unique/',
    location='us-central1',
    #    experiment='my-experiment',

    worker_pool_specs=[{
        "machine_spec": {
            "machine_type": "n1-standard-4"
        },
        "replica_count": 1
        }]
)
job.run()
