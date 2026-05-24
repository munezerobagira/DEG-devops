variable "vpc_id" {
  description = "ID of the VPC where compute resources will live."
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of public subnets for the EC2 instance."
  type        = list(string)
}

variable "allowed_ssh_cidr" {
  description = "Your IP address in CIDR notation allowed to SSH into the EC2 instance."
  type        = string
}

variable "s3_bucket_name" {
  description = "Globally unique name for the S3 static assets bucket."
  type        = string
}

variable "project_tag" {
  description = "Project tag value applied to compute resources."
  type        = string
}