variable "cluster_name" { 
  type = string 
}

variable "subnet_ids" { 
  type = list(string) 
}
variable "vpc_id" {
  type = string
}

variable "node_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "desired_size" {
  type    = number
  default = 2
}
