terraform {
  backend "s3" {
    bucket         = "multi-cluster-observability-tfstate"
    key            = "dev/observability/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "multi-cluster-observability-lock"
    encrypt        = true
  }
}
