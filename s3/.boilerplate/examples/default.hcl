{{- define "example_content" -}} 
{{ "\n" }}
  aws_region = local.aws_region
  bucket_list = {
      
    normal-bucket-default-values = {}
    
    normal-bucket-lifecycle-example = {
      force_destroy = false 
      s3_kms_encrypt = true
      versioning = false
      mfa_delete = false
      allow_ssl_request_only = true
      block_public_access = true
      # LifeCycle
      days_transition_to_glacier = 180
      days_to_delete = 365
      custom_lifecycle_rules = [
        {
          #All objects with tag glacier in true will be transitioned to glacier after 10 days
          id = "glacier"
          filter = {
            tags = {
              glacier = "true"
            }
          }
          transition = {
            days          = 10
            storage_class = "GLACIER"
          }
        },
        {
          #All objects in sub path /log with tag ia in true will be transitioned 
          #to standard ia after 15 days and deleted after 90 days
          id = "ia"
          filter = {
            prefix = "/logs"
            tags = {
              ia = "true"
            }
          }
          expiration_days = 90
          transition = {
            days          = 30
            storage_class = "STANDARD_IA"
          }
        },
        {
          # All objects in /tmp will be deleted after 7 days
          id = "tmp"
          filter = {
            prefix = "/tmp"
          }
          expiration_days = 7
        },
      ]
    }
    
    public-bucket-test-sbx = {
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