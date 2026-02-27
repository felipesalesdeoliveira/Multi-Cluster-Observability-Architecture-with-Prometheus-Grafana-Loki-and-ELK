variable "region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "az" {
  type    = string
  default = "us-east-1a"
}

variable "az_secondary" {
  type    = string
  default = "us-east-1b"
}

variable "app_cluster_name" {
  type    = string
  default = "dev-app-cluster"
}

variable "obs_cluster_name" {
  type    = string
  default = "dev-observability-cluster"
}

variable "app_vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "app_public_subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "app_public_subnet_cidr_secondary" {
  type    = string
  default = "10.10.3.0/24"
}

variable "app_private_subnet_cidr" {
  type    = string
  default = "10.10.2.0/24"
}

variable "app_private_subnet_cidr_secondary" {
  type    = string
  default = "10.10.4.0/24"
}

variable "obs_vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "obs_public_subnet_cidr" {
  type    = string
  default = "10.20.1.0/24"
}

variable "obs_public_subnet_cidr_secondary" {
  type    = string
  default = "10.20.3.0/24"
}

variable "obs_private_subnet_cidr" {
  type    = string
  default = "10.20.2.0/24"
}

variable "obs_private_subnet_cidr_secondary" {
  type    = string
  default = "10.20.4.0/24"
}

variable "node_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 3
}

variable "min_size" {
  type    = number
  default = 1
}

variable "oidc_thumbprint" {
  type    = string
  default = "9e99a48a9960b14926bb7f3b02e22da0ecd4e71a"
}

variable "app_fluentbit_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

variable "obs_prometheus_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

variable "tags" {
  type    = map(string)
  default = {}
}
