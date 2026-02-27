locals {
  common_tags = merge(
    {
      Environment = var.environment
      Project     = "multi-cluster-observability"
      ManagedBy   = "terraform"
      Layer       = "root"
    },
    var.tags
  )
}

provider "aws" {
  region = var.region
}

module "app" {
  source = "./environments/app"

  environment         = var.environment
  cluster_name        = var.app_cluster_name
  vpc_name            = "${var.environment}-app-vpc"
  vpc_cidr            = var.app_vpc_cidr
  public_subnet_cidr  = var.app_public_subnet_cidr
  private_subnet_cidr = var.app_private_subnet_cidr
  az                  = var.az
  peer_vpc_cidr       = var.obs_vpc_cidr

  node_instance_type   = var.node_instance_type
  desired_size         = var.desired_size
  max_size             = var.max_size
  min_size             = var.min_size
  oidc_thumbprint      = var.oidc_thumbprint
  fluentbit_policy_arn = var.app_fluentbit_policy_arn
  tags                 = local.common_tags
}

module "observability" {
  source = "./environments/observability"

  environment         = var.environment
  cluster_name        = var.obs_cluster_name
  vpc_name            = "${var.environment}-observability-vpc"
  vpc_cidr            = var.obs_vpc_cidr
  public_subnet_cidr  = var.obs_public_subnet_cidr
  private_subnet_cidr = var.obs_private_subnet_cidr
  az                  = var.az
  peer_vpc_cidr       = var.app_vpc_cidr

  node_instance_type    = var.node_instance_type
  desired_size          = var.desired_size
  max_size              = var.max_size
  min_size              = var.min_size
  oidc_thumbprint       = var.oidc_thumbprint
  prometheus_policy_arn = var.obs_prometheus_policy_arn
  tags                  = local.common_tags
}

module "peering" {
  source = "./modules/peering"

  vpc_id_requester         = module.app.vpc_id
  vpc_id_accepter          = module.observability.vpc_id
  requester_route_table_id = module.app.private_route_table_id
  accepter_route_table_id  = module.observability.private_route_table_id
  requester_cidr           = module.app.vpc_cidr
  accepter_cidr            = module.observability.vpc_cidr
  tags                     = local.common_tags
}

data "aws_eks_cluster" "app" {
  name = module.app.cluster_name
}

data "aws_eks_cluster_auth" "app" {
  name = module.app.cluster_name
}

data "aws_eks_cluster" "obs" {
  name = module.observability.cluster_name
}

data "aws_eks_cluster_auth" "obs" {
  name = module.observability.cluster_name
}

provider "helm" {
  alias = "app"

  kubernetes = {
    host                   = data.aws_eks_cluster.app.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.app.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.app.token
  }
}

provider "helm" {
  alias = "obs"

  kubernetes = {
    host                   = data.aws_eks_cluster.obs.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.obs.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.obs.token
  }
}

module "prometheus" {
  source    = "./modules/helm"
  providers = { helm = helm.obs }

  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  values     = [file("${path.root}/modules/helm/values/prometheus-values.yaml")]

  depends_on = [module.observability, module.peering]
}

module "grafana" {
  source    = "./modules/helm"
  providers = { helm = helm.obs }

  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "monitoring"
  values     = [file("${path.root}/modules/helm/values/grafana-values.yaml")]

  depends_on = [module.observability]
}

module "loki" {
  source    = "./modules/helm"
  providers = { helm = helm.obs }

  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  namespace  = "logging"
  values     = [file("${path.root}/modules/helm/values/loki-values.yaml")]

  depends_on = [module.observability]
}

module "fluent_bit" {
  source    = "./modules/helm"
  providers = { helm = helm.app }

  name       = "fluent-bit"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  namespace  = "logging"
  values     = [file("${path.root}/modules/helm/values/fluentbit-values.yaml")]

  depends_on = [module.app, module.loki, module.peering]
}
