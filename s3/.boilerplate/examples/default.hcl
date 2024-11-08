{{- define "example_content" -}} 
{{ "\n" }}
  bucket_list = {
    {{ .bucket_name }} = {
      force_destroy          = false
      versioning             = false
      mfa_delete             = false
      allow_ssl_request_only = true
      block_public_access    = true
    }
  }
{{- end -}}