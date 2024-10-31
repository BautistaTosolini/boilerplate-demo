{{- define "example_content" -}} 
  environment                    = "dev"
  rds_identifier                 = "example"
  rds_engine                     = "mariadb"
  rds_engine_version             = "10.11.6"
  rds_instance_class             = "db.t3.micro"
  rds_allocated_storage          = 20
  rds_storage_encrypted          = true
  rds_db_name                    = "example"
  rds_username                   = "example"
  rds_port                       = 3306
  subnet_ids                     = dependency.vpc.outputs.public_subnet_ids
  vpc_id                         = dependency.vpc.outputs.vpc_id
  availability_zones             = ["${local.aws_region}a", "${local.aws_region}b", "${local.aws_region}c"]
  region                         = local.aws_region
  allowed_cidr                   = [dependency.vpc.outputs.vpc_cidr_block, "0.0.0.0/0"]
  rds_backup_retention_period    = 7
  rds_deletion_protection        = false
  manage_master_user_password    = true
  performance_insights_enabled   = false
  rds_storage_type               = "gp3"
  parameter_group_name           = "default.mariadb10.11"
  rds_iops                       = 3000
  rds_publicly_accessible        = true
{{- end -}}