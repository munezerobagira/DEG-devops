output "s3_bucket_name" {
  description = "Name of the S3 static assets bucket."
  value       = aws_s3_bucket.assets.bucket
}