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
