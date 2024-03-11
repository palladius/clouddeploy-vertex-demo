#!/usr/bin/env python

'''Page6 in https://codelabs.developers.google.com/vertex-p2p-predictions?hl=en#4

get prediction for these flowers:

daisy  dandelion   roses  sunflowers  tulips

'''

from google.cloud import aiplatform

import numpy as np
from PIL import Image

from _env_gaic import *  # Import all the variables

#ENDPOINT_ID = '7074515098831683584' # via CLI
#ENDPOINT_ID = '393425051627552768' # via manhouse
ENDPOINT_ID = 6048820283698053120 # https://screenshot.googleplex.com/7WsSfKqiRbnSYMQ
# devconsole link: /vertex-ai/models/locations/us-central1/models/3738551740182560768/versions/1/deploy?e=-13802955&mods=logs_tg_staging&project=rick-and-nardy-demo
FLOWERS = [
    'daisy',
    'dandelion',
    'rose',
    'sunflower',
    'tulip',
]


def get_flower_prediction(predictions):
  """
  Finds the flower with the highest prediction probability.

  Args:
      predictions: A NumPy array of prediction probabilities.

  Returns:
      str: The flower name with the highest probability.
  """

  predicted_index = np.argmax(predictions)  # Index of the element with highest probability
  return FLOWERS[predicted_index]


endpoint = aiplatform.Endpoint(endpoint_name=f"projects/{PROJECT_NUMBER}/locations/us-central1/endpoints/{ENDPOINT_ID}")
#print(f"endpoint: {endpoint}")



IMAGE_PATH = "images/bulbi-di-tulipano-fiamma-128.png" # smaller dandelion
#IMAGE_PATH = "images/rosetta-30.jpg" # 50% smaller
#IMAGE_PATH =  "images/test-image_856.jpg" # Nikita wants me to use THIS: a dandelion
##########################
# These a broken:
# * "images/bulbi-di-tulipano-fiamma.jpg" # TOO BIG
# * "images/guns-n-xxxes.jpg" # google.api_core.exceptions.FailedPrecondition: 400 The request size (24724085 bytes) exceeds 1.500MB limit. [detail: "[ORIGINAL ERROR] generic::failed_precondition: The request size (24724085 bytes) exceeds 1.500MB limit. [google.rpc.error_details_ext] { message: \"The request size (24724085 bytes) exceeds 1.500MB limit.\" }"
# * "images/rosetta.jpg" # google.api_core.exceptions.FailedPrecondition: 400 The request size (7475485 bytes) exceeds 1.500MB limit. [detail: "[ORIGINAL ERROR] generic::failed_precondition: The request size (7475485 bytes) exceeds 1.500MB limit. [google.rpc.error_details_ext] { message: \"The request size (7475485 bytes) exceeds 1.500MB limit.\" }"
#############
im = Image.open(IMAGE_PATH)

x_test = np.asarray(im).astype(np.float32).tolist()

#print(f"Since it fails, let me show you the NUMPY buridone: {x_test}")

#prediction = endpoint.predict(instances=x_test).predictions
prediction = endpoint.predict(instances=[x_test]).predictions
# => [[2.69519293e-16, 3.98936721e-15, 1.0, 3.99677443e-13, 2.66888964e-08]]

print(f"🐈𓂀🦁 Prediction for file {IMAGE_PATH}: {prediction}")
five_results = np.array(prediction[0])
most_likely_flower = get_flower_prediction(five_results)
pct = np.max(five_results)
print(f"The sphinx has spoken -> {most_likely_flower} (probability: {pct*100}%)")
#The result you get is the output of the model, which is a softmax layer with 5 units. If you wanted to write custom logic to return the string label instead of the index, you can use custom prediction routines.


