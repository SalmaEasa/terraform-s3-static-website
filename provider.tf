terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  profile = "localstack"
  
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  #s3_use_path_style           = false

  endpoints {
    ec2            = "http://localhost:4566"
    s3             = "http://s3.localhost.localstack.cloud:4566"
    route53        = "http://localhost:4566"

  }
}