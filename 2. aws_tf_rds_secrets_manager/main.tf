terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
  backend "s3" {
    bucket = "my-rds-secrets-bucket"
    key    = "rds_tf_state/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}