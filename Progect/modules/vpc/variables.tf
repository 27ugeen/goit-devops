variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR"
}

variable "availability_zones" {
  type        = list(string)
  description = "AZs for subnets (e.g., [\"eu-central-1a\",\"eu-central-1b\",\"eu-central-1c\"])"
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDRs for public subnets (len must match AZs)"
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDRs for private subnets (len must match AZs)"
}

variable "vpc_name" {
  type        = string
  description = "Name tag for VPC"
}