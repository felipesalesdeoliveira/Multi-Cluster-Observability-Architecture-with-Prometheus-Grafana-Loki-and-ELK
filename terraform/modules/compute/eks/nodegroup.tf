resource "aws_eks_node_group" "system" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-system"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  capacity_type = "ON_DEMAND"
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  labels = {
    role = "system"
  }
}
resource "aws_eks_node_group" "spot" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-spot"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  capacity_type  = "SPOT"
  instance_types = ["t3.medium", "t3a.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 0
  }

  labels = {
    role = "spot"
  }
}
