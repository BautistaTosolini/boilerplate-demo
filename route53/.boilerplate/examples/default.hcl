{{- define "example_content" -}} 
  zone_name = "example.com"

  vpc_ids = [ dependency.vpc.outputs.vpc_id ]
{{- end -}}