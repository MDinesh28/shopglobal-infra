```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "shopglobal-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "eu_west_1"
}

module "us_east_1_infra" {
  source       = "../../modules/infra"
  providers = {
    aws = aws.us_east_1
  }
  project_name = var.project_name
  region       = "us-east-1"
  cidr_block   = var.cidr_blocks["us_east_1"]
}

module "eu_west_1_infra" {
  source       = "../../modules/infra"
  providers = {
    aws = aws.eu_west_1
  }
  project_name = var.project_name
  region       = "eu-west-1"
  cidr_block   = var.cidr_blocks["eu_west_1"]
}
```