#!/bin/bash
# Initialize Terraform backend for S3 state storage

set -e

BUCKET="shopglobal-terraform-state01"
REGION="us-east-1"
DYNAMODB_TABLE="terraform-locks"

# Check if AWS CLI is configured
if ! aws sts get-caller-identity > /dev/null 2>&1; then
  echo "Error: AWS credentials not configured. Please run 'aws configure' or attach an IAM role with permissions for S3, DynamoDB, and other required services."
  exit 1
fi

echo "Creating S3 bucket for Terraform state..."
# For us-east-1, omit LocationConstraint; for other regions, include it
if [ "$REGION" = "us-east-1" ]; then
  if aws s3api create-bucket --bucket "$BUCKET" --region "$REGION" 2>/dev/null; then
    echo "S3 bucket $BUCKET created."
  else
    echo "S3 bucket $BUCKET already exists or creation failed (possibly due to permissions or naming conflicts)."
  fi
else
  if aws s3api create-bucket --bucket "$BUCKET" --region "$REGION" --create-bucket-configuration LocationConstraint="$REGION" 2>/dev/null; then
    echo "S3 bucket $BUCKET created."
  else
    echo "S3 bucket $BUCKET already exists or creation failed (possibly due to permissions or naming conflicts)."
  fi
fi

echo "Enabling versioning on S3 bucket..."
if aws s3api put-bucket-versioning --bucket "$BUCKET" --versioning-configuration Status=Enabled 2>/dev/null; then
  echo "Versioning enabled on S3 bucket $BUCKET."
else
  echo "Failed to enable versioning on S3 bucket $BUCKET (bucket may not exist or permissions are insufficient)."
  exit 1
fi

echo "Creating DynamoDB table for state locking..."
if aws dynamodb create-table \
    --table-name "$DYNAMODB_TABLE" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region "$REGION" 2>/dev/null; then
  echo "DynamoDB table $DYNAMODB_TABLE created."
else
  echo "DynamoDB table $DYNAMODB_TABLE already exists or creation failed (possibly due to permissions)."
fi

echo "Initializing Terraform..."
terraform init
