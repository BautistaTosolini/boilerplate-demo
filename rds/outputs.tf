output "enhanced_monitoring_iam_role_name" {
  description = "The name of the monitoring role"
  value       = module.rds.enhanced_monitoring_iam_role_name
}

output "db_address" {
  description = "The address of the RDS instance"
  value       = module.rds.db_address
}

output "db_arn" {
  description = "The ARN of the RDS instance"
  value       = module.rds.db_arn
}

output "endpoint" {
  description = "The connection endpoint"
  value       = module.rds.endpoint
}

output "db_id" {
  description = "The RDS instance ID"
  value       = module.rds.db_id
}

output "db_name" {
  description = "The database name"
  value       = module.rds.db_name
}

output "db_username" {
  description = "The master username for the database"
  value       = module.rds.db_username
}