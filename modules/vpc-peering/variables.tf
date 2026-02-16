variable "vpc_id_requester" {
  type = string
}

variable "vpc_id_accepter" {
  type = string
}

variable "cidr_requester" {
  type = string
}

variable "cidr_accepter" {
  type = string
}

variable "requester_route_table_id" {
  type = string
}

variable "accepter_route_table_id" {
  type = string
}
