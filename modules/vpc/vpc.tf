resource "aws_vpc" "vpc-multi_cluster_observability" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "ig-multi_cluster_observability" {
  vpc_id = aws_vpc.vpc-multi_cluster_observability.id

  tags = {
    Name = "${var.name}-igw"
  }
}