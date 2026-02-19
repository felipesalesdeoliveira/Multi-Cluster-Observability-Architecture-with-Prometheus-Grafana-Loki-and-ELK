resource "aws_vpc" "vpc-multi_cluster_observability" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-${var.name}-vpc"
    Environment = var.environment
  }
}
