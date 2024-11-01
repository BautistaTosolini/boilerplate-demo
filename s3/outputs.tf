output "s3_buckets" {
  value = {
    for n, bucket in module.s3 : n => {
      bucket_id   = bucket.s3_bucket_id
      bucket_arn  = bucket.s3_bucket_arn
    }
  }
}