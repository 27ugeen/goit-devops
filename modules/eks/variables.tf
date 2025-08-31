variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the cluster will run"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "node_group_name" {
  type        = string
  description = "EKS managed node group name"
  default     = "ng-main"
}

variable "desired_size" {
  type        = number
  description = "Desired node count"
  default     = 2
}

variable "min_size" {
  type        = number
  description = "Min node count"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "Max node count"
  default     = 6
}

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for nodes"
  default     = ["t3.small"]
}

variable "disk_size" {
  type        = number
  description = "Node volume size (GiB)"
  default     = 20
}