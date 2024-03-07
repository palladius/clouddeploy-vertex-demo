
python3 -m trainer.task -v \
    --model_param_kernel=linear \
    --model_dir="gs://"$BUCKET_NAME"/titanic/trial" \
    --data_format=bigquery \
    --training_data_uri="bq://"$PROJECT_ID".titanic.survivors" \
    --test_data_uri="bq://"$PROJECT_ID".titanic.survivors" \
    --validation_data_uri="bq://"$PROJECT_ID".titanic.survivors"
