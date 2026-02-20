variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
  default     = "multi-cluster-observability"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
