#!/usr/bin/env python

# TODO move to sakura

print('🥺 Sorry this script is too important to be selfish and relegate it to a single re[po. This should be in SAKURA! look for `auto_import_config.py`')
# import yaml
# import os

# def inject_all_configs(config_data):
#     'Given a hash from YAML it creates one gcloud config per key'
#     # injects config as per tree.
#     for config_name, properties in config_data['configurations'].items():
#         # Create configuration if it doesn't exist
#         os.system(f"gcloud config configurations create {config_name}")

#         for property_name, value in properties.items():
#             os.system(f"gcloud config set {property_name} {value} --configuration {config_name}")

# def main():
#     #with open('.gcloudconfig.yaml', 'r') as file:
#     with open('.gcloudconfig.yaml', 'r') as file:
#         config_data = yaml.safe_load(file)

#     inject_all_configs(config_data)

#     # for k, val in config_data['local_config'].items():
#     #     print(f"{k} -> {val}")
#     if config_data['local_config']['auto'] == True:
#         full_dir =  os.getcwd()
#         local_dir = os.path.basename(full_dir)
#         # Alternative:
#         # last_part = current_dir.rsplit('/', 1)[1]
#         print(f'Setting config with same name as local dir: {local_dir}')
#         os.system(f"gcloud config configurations activate {local_dir}")
#     else:
#         print(f"local_config[auto] = '{ config_data['local_config']['auto'] }'")

#     # Final

#     os.system(f"gcloud config list")

# main()
