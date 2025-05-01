```
#!/bin/bash
# Initialize Terraform backend for S3 state storage

set -e

BUCKET="shopglobal-terraform-state"
REGION="us-east-1"
DYNAMODB_TABLE="terraform-locks"

echo "Creating S3 bucket for Terraform state..."
aws s3api create-bucket --bucket $BUCKET --region $REGION --create-bucket-configuration LocationConstraint=$REGION || true

echo "Enabling versioning on S3 bucket..."
aws s3api put-bucket-versioning --bucket $BUCKET --versioning-configuration Status=Enabled

echo "Creating DynamoDB table for state locking..."
aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region $REGION || true

echo "Initializing Terraform..."
terraform init
```