variable "name" {
  description = "VPC name"
  type        = string
}

variable "cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "public_subnet_cidr_secondary" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr_secondary" {
  type = string
}

variable "az" {
  description = "Availability Zone"
  type        = string
}

variable "az_secondary" {
  description = "Secondary Availability Zone"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
