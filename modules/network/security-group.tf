resource "aws_security_group" "eks" {
  name   = "${var.environment}-${var.name}-eks-sg"
  vpc_id = aws_vpc.vpc-multi_cluster_observability.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
