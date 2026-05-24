variable "s3_bucket_name" {
  description = "Globally unique name for the S3 static assets bucket."
  type        = string
}

variable "project_tag" {
  description = "Project tag value applied to storage resources."
  type        = string
}