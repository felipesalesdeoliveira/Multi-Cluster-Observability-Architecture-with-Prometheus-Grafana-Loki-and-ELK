variable "name" {
  type = string
}

variable "repository" {
  type = string
}

variable "chart" {
  type = string
}

variable "chart_version" {
  type    = string
  default = null
}

variable "namespace" {
  type = string
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "values" {
  type    = list(string)
  default = []
}
