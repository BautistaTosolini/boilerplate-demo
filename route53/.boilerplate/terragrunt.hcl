locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  # Automatically load environment-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  aws_region = local.region_vars.locals.aws_region
  aws_account_id = local.account_vars.locals.aws_account_id
  client_name = local.account_vars.locals.client_name
  environment = local.env_vars.locals.environment
}

terraform {
  source = "{{ .sourceUrl | replace "git::ssh://git@github.com/craftech-io/" "tfr://registry.craftech.io/craftech/" | replace "?ref=" (printf "?version=%s" .moduleVersion) }}"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  # --------------------------------------------------------------------------------------------------------------------
  # Required input variables
  #
  # Add all required module variables here.
  # As a convention try to use locals as much as you can.
  # --------------------------------------------------------------------------------------------------------------------
  
  # These two required variables example are filled with locals content to improve
  # name standarization, and make easy the example use.
  aws_region                = local.aws_region  
  principal_resource_name   = "${local.client_name}-${local.environment}"
  # This variable is readed from the UI as it's defined in the
  # boilerplate.yml file.
  required_variable         = "{{ .required_variable }}"
  
  # -------------------------------------
  # Do not touch anything below this line
  # -------------------------------------

  {{ if ne .exampleName "do_not_use_example" }}
  # --------------------------------------------------------------------------------------------------------------------
  # Variables defined by example:
  # {{ .exampleName }} 
  # --------------------------------------------------------------------------------------------------------------------
  {{- template "example_content" . -}}
  {{else}}

  # --------------------------------------------------------------------------------------------------------------------
  # Optional input variables
  # Uncomment the ones you wish to set
  # --------------------------------------------------------------------------------------------------------------------
  {{ range .optionalVariables }}
  # Description: {{ .Description }}
  # Type: {{ .Type }}
  # {{ .Name }} = {{ .DefaultValue }}
  {{ end }}
  {{ end }}
}