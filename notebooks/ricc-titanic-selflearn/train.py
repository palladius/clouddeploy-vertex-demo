
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier  # Sample model
from sklearn.metrics import accuracy_score

from google.cloud import aiplatform as vertex
from google.cloud import storage

# Initialization
project = "rick-and-nardy-demo"
location = "us-central1"
#bucket = f"{project}-{location}-tf-dev-backend"
bucket = "your-bucket-name-rick-and-nardy-demo-unique"

vertex.init(project=project,
            location=location,
            staging_bucket=f"gs://{bucket}",
            )

# 1. Load and Prepare Data
df = pd.read_csv("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv")
df = df.dropna()  # Simple cleaning
X = df.drop("Survived", axis=1)
y = df["Survived"]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# 2. Create Vertex AI Training Job
# job = vertex.CustomTrainingJob(
#     display_name="titanic-demo-ricc",
#     worker_pool_specs=[{
#         "machine_type": "n1-standard-4",  # Adjust if needed
#         "container_spec": {
#                 "image_uri": "gcr.io/cloud-aiplatform/training/scikit-learn:latest",
#                 "command": [],
#                 "args": [
#                     # this gives me error: AttributeError: module 'google.cloud.aiplatform' has no attribute 'storage'
#                     #"--training_dataset_path", vertex.storage.Inputs.input("training"),
#                     "--model_dir", vertex.storage.Outputs.output("model_dir")
#                     ]
#         }
#     }]
# )

# Now create a Vertex AI Training job
# ad mentulam canis, copied from Gemini and adapted until it worked (yes I checked for GCR.IO scitki repos)
job = vertex.CustomJob(
    display_name="ricc-training-job-async-amc",
    worker_pool_specs=[{
        "machine_spec": {           "machine_type": "n1-standard-4"},
        "replica_count": 1,
        "container_spec": {
                 "image_uri": "gcr.io/cloud-aiplatform/training/scikit-learn-cpu.0-23:latest",
        }
    }],
)
job.run(sync=False)

print("Riccardo: first training job enqueued async.")
# job pending: gcr.io/cloud-aiplatform/training/scikit-learn-cpu.0-23

# 3. Run the Job
job.run(
    training_dataset_path="gs://your-bucket/titanic_train.csv",
    model_dir="gs://your-bucket/model_output/",
    # Hyperparameters as needed
    sync=False
)

# 4. Evaluate Model (After job completes)
# Load model from output and evaluate like normal scikit-learn models
