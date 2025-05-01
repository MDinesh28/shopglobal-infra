# ShopGlobal Infrastructure as Code

This repository manages ShopGlobal's AWS infrastructure using Terraform. It provisions VPC, EC2, RDS, and compliance-related resources in multiple regions (us-east-1, eu-west-1) to support global e-commerce expansion.

## Prerequisites
- Terraform >= 1.5.0
- AWS CLI configured with credentials
- Access to an S3 bucket and DynamoDB table for state management

## Repository Structure
- `main.tf`: Core configuration with providers and module calls.
- `variables.tf`, `outputs.tf`: Global variables and outputs.
- `modules/infra/`: Reusable module for VPC, EC2, RDS, etc.
- `environments/`: Environment-specific configurations (dev, prod).
- `scripts/`: Helper scripts for automation.

## Setup
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd shopglobal-infra
   cd environments/dev         # or environments/prod
   terraform init
   terraform plan -var-file=terraform.tfvars
   terraform apply -var-file=terraform.tfvars
