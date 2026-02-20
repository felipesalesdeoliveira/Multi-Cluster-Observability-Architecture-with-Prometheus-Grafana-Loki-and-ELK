resource "aws_security_group" "cluster_sg" {
  name   = "${var.name}-cluster-sg"
  vpc_id = var.vpc_id

  tags = var.tags
}

# Permitir comunicação interna Kubernetes
resource "aws_security_group_rule" "internal" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr_peer]
  security_group_id = aws_security_group.cluster_sg.id
}

# Permitir saída total
resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cluster_sg.id
}
