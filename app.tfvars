region       = "us-east-1"
environment  = "dev"
az           = "us-east-1a"
az_secondary = "us-east-1b"

app_cluster_name = "dev-app-cluster"
obs_cluster_name = "dev-observability-cluster"

app_vpc_cidr                      = "10.10.0.0/16"
app_public_subnet_cidr            = "10.10.1.0/24"
app_public_subnet_cidr_secondary  = "10.10.3.0/24"
app_private_subnet_cidr           = "10.10.2.0/24"
app_private_subnet_cidr_secondary = "10.10.4.0/24"

obs_vpc_cidr                      = "10.20.0.0/16"
obs_public_subnet_cidr            = "10.20.1.0/24"
obs_public_subnet_cidr_secondary  = "10.20.3.0/24"
obs_private_subnet_cidr           = "10.20.2.0/24"
obs_private_subnet_cidr_secondary = "10.20.4.0/24"
