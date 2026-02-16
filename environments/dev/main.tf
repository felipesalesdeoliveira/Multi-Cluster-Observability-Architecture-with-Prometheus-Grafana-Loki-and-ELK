module "vpc_app" {
  source = "../../modules/vpc"

  name = "vpc-app"
  cidr = "10.0.0.0/16"
  azs  = var.azs
}

module "vpc_obs" {
  source = "../../modules/vpc"

  name = "vpc-observability"
  cidr = "10.1.0.0/16"
  azs  = var.azs
}
module "vpc_peering" {
  source = "../../modules/vpc-peering"

  vpc_id_requester = module.vpc_app.vpc_id
  vpc_id_accepter  = module.vpc_obs.vpc_id

  cidr_requester = "10.0.0.0/16"
  cidr_accepter  = "10.1.0.0/16"

  requester_route_table_id = module.vpc_app.private_route_table_id
  accepter_route_table_id  = module.vpc_obs.private_route_table_id
}
