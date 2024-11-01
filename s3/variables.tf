variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_list" {
  description = "S3 bucket definition for each client"
  type        = any
}

variable "tags" {
  description = "Tags for the created bucket"
  type        = map(string)
  default     = {}
}