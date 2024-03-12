
#!/bin/bash

echo 1. Models in dflt region:

gcloud ai models list
# Using endpoint [https://us-central1-aiplatform.googleapis.com/]
# MODEL_ID             DISPLAY_NAME
# 977000743674314752   test-model
# 3485927948584747008  california_reg_model

echo 2./ Lets double click on ivan model:

# to automate:
#IVAN_MODEL_ID=$(gcloud ai models list | grep california_reg_model | awk '{print $1}' )
#gcloud ai models describe $(IVAN_MODEL_ID)

# FASTER:
gcloud ai models describe 3485927948584747008
