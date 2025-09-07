variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "namespace" {
  type    = string
  default = "jenkins"
}

variable "chart_version" {
  type    = string
  default = "5.5.10"
}