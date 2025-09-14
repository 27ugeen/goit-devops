output "db_endpoint" {
  description = "Database endpoint (RDS or Aurora)"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].endpoint : aws_db_instance.this[0].endpoint
}

output "db_name" {
  description = "Database name"
  value       = var.db_name
}

output "db_engine" {
  description = "Database engine"
  value       = var.use_aurora ? var.engine_cluster : var.engine
}

output "db_engine_version" {
  description = "Database engine version"
  value       = var.use_aurora ? var.engine_version_cluster : var.engine_version
}