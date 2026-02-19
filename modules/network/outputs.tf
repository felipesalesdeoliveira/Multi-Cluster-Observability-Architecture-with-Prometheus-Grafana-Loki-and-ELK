output "vpc_id" {
  value = aws_vpc.vpc-multi_cluster_observability.id
}

output "public_subnets" {
  value = [aws_subnet.public.id]
}

output "private_subnets" {
  value = [aws_subnet.private.id]
}

output "eks_security_group" {
  value = aws_security_group.eks.id
}
