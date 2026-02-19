variable "vpc_id" {
  description = "VPC ID origem"
  type        = string
}

variable "peer_vpc_id" {
  description = "VPC ID destino"
  type        = string
}

variable "route_table_ids" {
  description = "Lista de route tables da VPC origem"
  type        = list(string)
}

variable "peer_route_table_ids" {
  description = "Lista de route tables da VPC destino"
  type        = list(string)
}

variable "peer_cidr_block" {
  description = "CIDR da VPC destino"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR da VPC origem"
  type        = string
}
