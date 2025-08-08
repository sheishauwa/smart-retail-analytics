import os
import zipfile
import boto3
from kaggle.api.kaggle_api_extended import KaggleApi

# AWS and S3 settings
S3_BUCKET = os.environ.get("S3_BUCKET", "smart-retail-raw-zone")
REGION = os.environ.get("AWS_REGION", "us-east-1")

# Initialize Kaggle API
api = KaggleApi()
api.authenticate()

# Download dataset from Kaggle
print("Downloading dataset from Kaggle...")
api.competition_download_files('walmart-recruiting-store-sales-forecasting', path='/tmp')

# Extract files
zip_path = '/tmp/walmart-recruiting-store-sales-forecasting.zip'
extract_path = '/tmp/walmart_data'
os.makedirs(extract_path, exist_ok=True)

with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extractall(extract_path)

# Upload to S3
s3_client = boto3.client('s3', region_name=REGION)
for root, dirs, files in os.walk(extract_path):
    for file in files:
        file_path = os.path.join(root, file)
        s3_key = f"raw/{file}"
        print(f"Uploading {file_path} to s3://{S3_BUCKET}/{s3_key}")
        s3_client.upload_file(file_path, S3_BUCKET, s3_key)

print("Dataset ingestion complete.")

