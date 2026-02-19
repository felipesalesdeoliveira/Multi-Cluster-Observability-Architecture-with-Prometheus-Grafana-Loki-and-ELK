terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "Terraform State Bucket"
    key            = "dev/peering/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "SEU_DYNAMODB_LOCK"
    encrypt        = true
  }
}
