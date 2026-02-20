variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_peer" {
  description = "CIDR da VPC que poderá acessar"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
