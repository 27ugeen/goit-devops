variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDRs (one per AZ)"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet CIDRs (one per AZ)"
}

variable "availability_zones" {
  type        = list(string)
  description = "AZs to use, same count as subnets"
}

variable "vpc_name" {
  type        = string
  description = "VPC name tag"
}