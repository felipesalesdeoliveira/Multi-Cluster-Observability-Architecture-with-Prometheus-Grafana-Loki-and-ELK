terraform {
  backend "s3" {
    bucket = "multi-observability-tf-state-dev"
    key    = "app-observability/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
