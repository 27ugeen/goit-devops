variable "name" {
  description = "Name of the DB instance or cluster"
  type        = string
}

# RDS-only
variable "engine" {
  description = "DB engine for RDS (postgres | mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version for RDS (see aws rds describe-db-engine-versions)"
  type        = string
  default     = "14.7"
}

variable "parameter_group_family_rds" {
  description = "Parameter group family for RDS (e.g., postgres15, mysql8.0)"
  type        = string
  default     = "postgres15"
}

# Aurora-only
variable "engine_cluster" {
  description = "Aurora engine (aurora-postgresql | aurora-mysql)"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version_cluster" {
  description = "Aurora engine version (see aws rds describe-db-engine-versions --engine aurora-*)"
  type        = string
  default     = "15.3"
}

variable "parameter_group_family_aurora" {
  description = "Parameter group family for Aurora (e.g., aurora-postgresql15)"
  type        = string
  default     = "aurora-postgresql15"
}

variable "aurora_instance_count" {
  description = "Total instances in Aurora cluster (1 writer + readers)"
  type        = number
  default     = 2
}

variable "aurora_replica_count" {
  description = "Number of reader replicas (alternative to aurora_instance_count-1)"
  type        = number
  default     = 1
}

# Common
variable "use_aurora" {
  description = "true = Aurora, false = standard RDS"
  type        = bool
  default     = false
}

variable "instance_class" {
  description = "Instance class (e.g., db.t3.micro)"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage size in GiB (RDS only; Aurora ignores this)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "username" {
  description = "Master username (avoid reserved names like 'admin')"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_private_ids" {
  description = "Private subnet IDs for DB subnet group"
  type        = list(string)
}

variable "subnet_public_ids" {
  description = "Public subnet IDs (optional)"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Whether the DB is publicly accessible"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable Multi-AZ for RDS"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Number of days to retain backups (\"\" -> 0)"
  type        = string
  default     = ""
}

variable "parameters" {
  description = "Custom parameter overrides (key=value)"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}