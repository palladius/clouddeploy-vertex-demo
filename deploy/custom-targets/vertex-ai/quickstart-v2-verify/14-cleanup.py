#!/usr/bin/env python3

"""Unfortunately this cant be done in BASH."""

# Derek: $ sudo apt-get install python3-googleapi
from googleapiclient import discovery

def delete_endpoint_aliases(endpoint_id, version_aliases, project, location):
    ai_platform = discovery.build('aiplatform', 'v1')
    endpoint_path = f'projects/{project}/locations/{location}/endpoints/{endpoint_id}'

    response = ai_platform.projects().locations().endpoints().patch(
        name=endpoint_path,
        updateMask='deployedModels',
        body={
            'deployedModels': [
                {
                    # ... other deployed model config, if needed ...
                    'versionAliases': version_aliases
                }
            ]
        }
    ).execute()

# Example usage:
endpoint_id = "8413639997114023936" # credo
# https://pantheon.corp.google.com/vertex-ai/models/locations/us-central1/models/8413639997114023936/versions/2/deploy?project=rick-and-nardy-demo
v2_endpoint_id = "2276000064612597760" # from output of 09.sh
version_aliases = [
    "remove-my-alias"
]  # Empty list to clear aliases
project = "rick-and-nardy-demo"
#PROJECT_ID = "rick-and-nardy-demo"
location = "us-central1"

#delete_endpoint_aliases(v2_endpoint_id, version_aliases, project, location)
delete_endpoint_aliases(endpoint_id, version_aliases, project, location)
