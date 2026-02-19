resource "aws_security_group" "eks_cluster" {
  name   = "${var.name}-eks-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "intra_cluster" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_cluster.id
  self              = true
}
resource "aws_security_group_rule" "allow_from_app" {
  type                     = "ingress"
  from_port                = 9090
  to_port                  = 9090
  protocol                 = "tcp"
  security_group_id        = var.obs_sg_id
  source_security_group_id = var.app_sg_id
}
resource "aws_security_group_rule" "allow_obs_to_app" {
  count = var.app_sg_id != null && var.obs_sg_id != null ? 1 : 0

  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = var.app_sg_id
  source_security_group_id = var.obs_sg_id
}
resource "aws_security_group_rule" "allow_app_to_loki" {
  count = var.app_sg_id != null && var.obs_sg_id != null ? 1 : 0

  type                     = "ingress"
  from_port                = 3100
  to_port                  = 3100
  protocol                 = "tcp"
  security_group_id        = var.obs_sg_id
  source_security_group_id = var.app_sg_id
}
