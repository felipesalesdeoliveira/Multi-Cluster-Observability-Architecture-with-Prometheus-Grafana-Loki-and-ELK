variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_projeto-00" {
  description = "S3 bucket for Terraform state"
  type        = string
}

variable "dynamodb_table_projeto-00" {
  description = "DynamoDB table for state lock"
  type        = string
}
