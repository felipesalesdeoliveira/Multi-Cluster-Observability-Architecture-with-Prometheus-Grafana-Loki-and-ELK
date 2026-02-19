module "vpc_peering" {
  source = "../../../../modules/vpc-peering"

  vpc_app_id  = var.vpc_app_id
  vpc_obs_id  = var.vpc_obs_id

  app_cidr = var.app_cidr
  obs_cidr = var.obs_cidr

  app_route_table_ids = var.app_route_table_ids
  obs_route_table_ids = var.obs_route_table_ids
}
