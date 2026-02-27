output "app_cluster_name" { value = module.app.cluster_name }
output "observability_cluster_name" { value = module.observability.cluster_name }
output "app_vpc_id" { value = module.app.vpc_id }
output "observability_vpc_id" { value = module.observability.vpc_id }
output "vpc_peering_id" { value = module.peering.peering_id }
output "app_cluster_endpoint" { value = module.app.cluster_endpoint }
output "observability_cluster_endpoint" { value = module.observability.cluster_endpoint }
