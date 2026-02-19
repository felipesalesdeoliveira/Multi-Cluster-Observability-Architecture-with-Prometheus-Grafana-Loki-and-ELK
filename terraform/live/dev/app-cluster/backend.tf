terraform {
  backend "s3" {
    bucket = "multi-cluster-tf-state-dev"
    key    = "app-cluster/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
