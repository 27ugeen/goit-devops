variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "node_group_name" {
  type    = string
  default = "ng-main"
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 4
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.small"]
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "kubernetes_version" {
  type    = string
  default = "1.33"
}