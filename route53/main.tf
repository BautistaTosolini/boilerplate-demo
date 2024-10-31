# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPLOY ROUTE53 HOSTED ZONE WITH RECORDS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 1.0.0, <=1.5.5"
}

# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  # The AWS region in which all resources will be created
  region = var.aws_region
}


module "route53" {
  source          = "registry.craftech.io/craftech/terraform-aws-route53/aws//modules/route53"
  version         = "1.0.0"
  zone_name       = var.zone_name
  record_config   = var.record_config
  zone_comment    = var.zone_comment
  force_destroy   = var.force_destroy
  allow_overwrite = var.allow_overwrite
  alias_config    = var.alias_config
  vpc_ids         = var.vpc_ids
}