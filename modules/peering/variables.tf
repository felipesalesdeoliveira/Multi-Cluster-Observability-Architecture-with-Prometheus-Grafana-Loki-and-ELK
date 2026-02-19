variable "vpc_app_id" {
  type = string
}

variable "vpc_obs_id" {
  type = string
}

variable "app_cidr" {
  type = string
}

variable "obs_cidr" {
  type = string
}

variable "app_route_table_ids" {
  type = list(string)
}

variable "obs_route_table_ids" {
  type = list(string)
}
