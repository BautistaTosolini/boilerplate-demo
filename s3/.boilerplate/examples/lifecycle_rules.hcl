{{- define "example_content" -}} 
{{ "\n" }}
  bucket_list = {

    {{ .bucket_name }} = {
      versioning = false
      mfa_delete = false
      force_destroy = false          
      s3_kms_encrypt = true
      # By default is aws/s3 KMS key
      # kms_key_id = "ID"
      allow_ssl_request_only = true
      block_public_access = false
      object_ownership = "BucketOwnerPreferred"
      acl = "public-read"
      acl_grant_rules = [
        {
          uri        = "http://acs.amazonaws.com/groups/global/AllUsers",
          permission = "READ"
        }
      ]
      custom_policies = [
        {
          sid        = "PublicRead"
          actions    = [
            "s3:GetObject",
            "s3:GetObjectVersion"
          ]
          resources  = ["*"]
          principals = {
            type        = "*"
            identifiers = ["*"]
          }           
        }
      ]
    }
  }
{{- end -}}