variable "name" {
  type        = string
  description = "Prefixo do security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "app_sg_id" {
  type        = string
  description = "Security Group do cluster app"
  default     = null
}

variable "obs_sg_id" {
  type        = string
  description = "Security Group do cluster observability"
  default     = null
}
