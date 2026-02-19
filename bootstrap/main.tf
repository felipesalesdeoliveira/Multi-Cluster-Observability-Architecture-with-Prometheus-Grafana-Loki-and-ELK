############################################
# S3 BUCKET FOR TERRAFORM STATE
############################################

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_projeto-00

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "global"
    Project     = "multi-cluster-observability"
  }
}

############################################
# VERSIONING ENABLED
############################################

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

############################################
# SERVER SIDE ENCRYPTION
############################################

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

############################################
# BLOCK PUBLIC ACCESS (SECURITY BEST PRACTICE)
############################################

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

############################################
# DYNAMODB TABLE FOR STATE LOCK
############################################

resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table_projeto-00
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "global"
    Project     = "multi-cluster-observability"
  }
}
