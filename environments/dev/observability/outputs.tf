output "vpc_id" {
  value = module.observability_network.vpc_id
}

output "private_subnets" {
  value = module.observability_network.private_subnets
}

output "public_subnets" {
  value = module.observability_network.public_subnets
}
