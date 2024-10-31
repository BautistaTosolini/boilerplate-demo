# ----------------------------------------------------------------------------------------------------------------------
# LAUNCH AMAZON INSTANCE
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  # compatible with TF 1.X.X.x code.
  required_version = ">= 1.0.0, <=1.5.5"
}

# ----------------------------------------------------------------------------------------------------------------------
# CONFIGURE AWS CONNECTION
# ----------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region
}

# ----------------------------------------------------------------------------------------------------------------------
# DB INSTANCE
# Amazon RDS supports DB instances running several editions of PostgreSQL, see for more information:
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html
# ----------------------------------------------------------------------------------------------------------------------
module "rds" {
  source              = "registry.craftech.io/craftech/module-databases/aws//modules/rds"
  version             = "1.4.1"
  environment         = var.environment
  identifier          = var.rds_identifier
  engine              = var.rds_engine
  engine_version      = var.rds_engine_version
  instance_class      = var.rds_instance_class
  allocated_storage   = var.rds_allocated_storage
  storage_encrypted   = var.rds_storage_encrypted
  storage_type        = var.rds_storage_type
  db_name             = var.rds_db_name
  snapshot_identifier = var.rds_snapshot_identifier
  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username                    = var.rds_username
  manage_master_user_password = var.manage_master_user_password
  port                        = var.rds_port
  maintenance_window          = var.rds_maintenance_window
  backup_window               = var.rds_backup_window
  password                    = var.password

  # disable backups to create DB faster
  backup_retention_period         = var.rds_backup_retention_period
  enabled_cloudwatch_logs_exports = var.rds_enabled_cloudwatch_logs_exports
  deletion_protection             = var.rds_deletion_protection
  subnet_ids                      = var.subnet_ids
  vpc_id                          = var.vpc_id
  allowed_cidr                    = var.allowed_cidr
  # using apply_immediately can result in a brief downtime as the server reboots. See the AWS Docs on
  # RDS Maintenance https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html
  apply_immediately            = var.rds_apply_immediately
  tags                         = var.rds_tags
  iops                         = var.rds_iops
  performance_insights_enabled = var.performance_insights_enabled
  copy_tags_to_snapshot        = var.rds_copy_tags_to_snapshot
  parameter_group_name         = var.rds_parameter_group_name
  publicly_accessible          = var.rds_publicly_accessible
}