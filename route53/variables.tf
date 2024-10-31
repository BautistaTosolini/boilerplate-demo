# ----------------------------------------------------------------------------------------------------------------------
# variable needed by submodule to implement main module
# ----------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS Region where this VPC will exist."
  type        = string
  default     = "us-east-1"
}

# ----------------------------------------------------------------------------------------------------------------------
# ZONE
# ----------------------------------------------------------------------------------------------------------------------

variable "zone_name" {
  description = "Domain name for the hosted zone, e.g: mydomain.com"
  type        = string
}

variable "zone_comment" {
  description = "(Optional) A comment for the hosted zone. Defaults to 'Managed by Terraform'"
  type        = string
  default     = "Managed by Craftech"
}

variable "force_destroy" {
  description = "(Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  type        = bool
  default     = false
}

variable "vpc_ids" {
  description = "(Optional) List of VPC(s) to associate with a private hosted zone."
  type        = list(string)
  default     = []
}

# ----------------------------------------------------------------------------------------------------------------------
# RECORD
# ----------------------------------------------------------------------------------------------------------------------

variable "record_config" {
  description = "Map of map of Route53 records to create, defining name (host), type, ttl and records (where the records points to)"
  type        = map(any)
  default     = {}
}

variable "allow_overwrite" {
  description = "Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments."
  type        = bool
  default     = false
}

# ----------------------------------------------------------------------------------------------------------------------
# ALIAS RECORD
# ----------------------------------------------------------------------------------------------------------------------

variable "alias_enable" {
  description = "Allow creation alias record."
  type        = bool
  default     = false
}

# name: (Required) DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone
variable "alias_config" {
  description = "Map of map of aliases to create"
  type = map(object({
    name                   = string
    alias_target           = string
    type                   = string
    evaluate_target_health = bool
    zone_id                = string
  }))
  default = {}
}