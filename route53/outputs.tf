# ----------------------------------------------------------------------------------------------------------------------
# Outputs to implement main module
# ----------------------------------------------------------------------------------------------------------------------
output "zone_id" {
  description = "The Hosted Zone ID. This can be referenced by zone records."
  value       = module.route53.zone_id
}

output "name_servers" {
  description = "The list of DNS name servers for the Hosted Zone."
  value       = module.route53.name_servers
}