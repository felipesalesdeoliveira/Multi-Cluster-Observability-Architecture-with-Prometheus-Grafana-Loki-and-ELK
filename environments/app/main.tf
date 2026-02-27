locals {
  common_tags = merge(
    {
      Environment = var.environment
      Cluster     = var.cluster_name
      ManagedBy   = "terraform"
      Layer       = "environment"
    },
    var.tags
  )
}

module "vpc" {
  source = "../../modules/vpc"

  name                          = var.vpc_name
  cidr                          = var.vpc_cidr
  public_subnet_cidr            = var.public_subnet_cidr
  public_subnet_cidr_secondary  = var.public_subnet_cidr_secondary
  private_subnet_cidr           = var.private_subnet_cidr
  private_subnet_cidr_secondary = var.private_subnet_cidr_secondary
  az                            = var.az
  az_secondary                  = var.az_secondary
  tags                          = local.common_tags
}

resource "aws_security_group" "cluster_sg" {
  name   = "${var.cluster_name}-cluster-sg"
  vpc_id = module.vpc.vpc_id
  tags   = local.common_tags
}

resource "aws_security_group_rule" "internal_peer" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.peer_vpc_cidr]
  security_group_id = aws_security_group.cluster_sg.id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cluster_sg.id
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [aws_security_group.cluster_sg.id]

  node_instance_type = var.node_instance_type
  desired_size       = var.desired_size
  max_size           = var.max_size
  min_size           = var.min_size
  tags               = local.common_tags
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.oidc_thumbprint]
  url             = module.eks.oidc_issuer

  tags = local.common_tags
}

module "irsa_fluent_bit" {
  source = "../../modules/iam"

  cluster_name         = var.cluster_name
  oidc_provider_arn    = aws_iam_openid_connect_provider.this.arn
  namespace            = "logging"
  service_account_name = "fluent-bit"
  policy_arn           = var.fluentbit_policy_arn
  tags                 = local.common_tags
}
