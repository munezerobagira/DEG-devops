variable "vpc_id" {
  description = "ID of the VPC where the database resources will live."
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets for the RDS instance."
  type        = list(string)
}

variable "web_sg_id" {
  description = "Security group ID of the web tier allowed to connect to PostgreSQL."
  type        = string
}

variable "db_username" {
  description = "Master username for the RDS instance."
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS instance."
  type        = string
  sensitive   = true
}

variable "project_tag" {
  description = "Project tag value applied to database resources."
  type        = string
}