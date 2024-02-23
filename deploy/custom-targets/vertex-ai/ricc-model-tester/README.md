You can now execute queries using the command line interface (CLI).

Make sure that you have the Google Cloud SDK  installed.
Run the following command to authenticate with your Google account.
$
gcloud auth application-default login
Create a JSON object to hold your data.
{
  "instances": [
    { "instance_key_1": "value", ... }, ...
  ],
  "parameters": { "parameter_key_1": "value", ... }, ...
}
Create environment variables to hold your endpoint and project IDs, as well as your JSON object.
$
ENDPOINT_ID="quickstart-prod"
PROJECT_ID="849075740253"
INPUT_DATA_FILE="INPUT-JSON"
Execute the request.
$
curl \
-X POST \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H "Content-Type: application/json" \
https://us-central1-aiplatform.googleapis.com/v1/projects/${PROJECT_ID}/locations/us-central1/endpoints/${ENDPOINT_ID}:predict \
-d "@${INPUT_DATA_FILE}"
