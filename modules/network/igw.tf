resource "aws_internet_gateway" "igw-multi_cluster_observability" {
  vpc_id = aws_vpc.vpc-multi_cluster_observability.id

  tags = {
    Name = "${var.environment}-${var.name}-igw"
  }
}
