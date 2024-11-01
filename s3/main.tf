# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  # The AWS region in which all resources will be created
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE S3  BUCKETS
# ---------------------------------------------------------------------------------------------------------------------

module "s3" {
  source     = "registry.craftech.io/craftech/module-data-storage/aws//modules/s3"
  version    = "1.0.0"

  for_each = var.bucket_list

  bucket_name                = each.key
  force_destroy_bucket       = lookup(each.value, "force_destroy", false)
  s3_kms_encrypt             = lookup(each.value, "s3_kms_encrypt", false)
  kms_key_id                 = lookup(each.value, "kms_key_id", null)
  versioning                 = lookup(each.value, "versioning", false)
  mfa_delete                 = lookup(each.value, "mfa_delete", false)
  policy_id                  = lookup(each.value, "policy_id", "S3PolicyDefault")
  custom_policies            = lookup(each.value, "custom_policies", [])
  allow_ssl_request_only     = lookup(each.value, "allow_ssl_request_only", false)
  acl                        = lookup(each.value, "acl", "")
  acl_grant_rules            = lookup(each.value, "acl_grant_rules", [])
  days_transition_to_glacier = lookup(each.value, "days_transition_to_glacier", 0)
  days_to_delete             = lookup(each.value, "days_to_delete", 0)
  custom_lifecycle_rules     = lookup(each.value, "custom_lifecycle_rules", [])
  block_public_access        = lookup(each.value, "block_public_access", true) == true ? true : false
  object_ownership           = length(lookup(each.value, "object_ownership", "")) > 0 ? lookup(each.value, "object_ownership") : null
  tags                       = merge(var.tags, lookup(each.value, "tags", {}))
}