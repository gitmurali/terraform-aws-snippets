# this provides configuration to aws
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# provides the information to access aws specifically
provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}
