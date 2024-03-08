#!/usr/bin/env python

'''Page6 in https://codelabs.developers.google.com/vertex-p2p-predictions?hl=en#4

get prediction
'''

from google.cloud import aiplatform

import numpy as np
from PIL import Image

from _env_gaic import *  # Import all the variables

ENDPOINT_ID = '7074515098831683584'

endpoint = aiplatform.Endpoint(
    endpoint_name=f"projects/{PROJECT_NUMBER}/locations/us-central1/endpoints/{ENDPOINT_ID}")

print(f"endpoint: {endpoint}")

#IMAGE_PATH = "test-image.jpg"
#IMAGE_PATH = "images/guns-n-xxxes.jpg"
#IMAGE_PATH = "images/bulbi-di-tulipano-fiamma.jpg"
IMAGE_PATH = "images/rosetta.jpg"

im = Image.open(IMAGE_PATH)

x_test = np.asarray(im).astype(np.float32).tolist()

prediction = endpoint.predict(instances=x_test).predictions

print(f"🐈𓂀🦁 Prediction for file {IMAGE_PATH}: {prediction}")

#The result you get is the output of the model, which is a softmax layer with 5 units. If you wanted to write custom logic to return the string label instead of the index, you can use custom prediction routines.


