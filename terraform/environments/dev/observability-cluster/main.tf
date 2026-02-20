module "vpc" {
  source     = "../../../modules/networking/vpc"
  name       = "dev-observability-vpc"
  cidr_block = "10.20.0.0/16"
  azs        = ["us-east-1a"]
}

module "eks" {
  source       = "../../../modules/compute/eks"
  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.private_subnet_ids
  vpc_id       = module.vpc.vpc_id
}
