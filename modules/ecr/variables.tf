variable "ecr_name" {
  type        = string
  description = "ECR repository name"
}

variable "scan_on_push" {
  type        = bool
  description = "Enable image scanning on push"
  default     = true
}