terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment and configure once your S3 backend bucket exists.
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "vela-payments/terraform.tfstate"
  #   region = var.aws_region
  # }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source      = "./modules/networking"
  vpc_cidr    = var.vpc_cidr
  project_tag = var.project_tag
}

module "compute" {
  source = "./modules/compute"

  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  allowed_ssh_cidr  = var.allowed_ssh_cidr
  s3_bucket_name    = var.s3_bucket_name
  project_tag       = var.project_tag
}

module "storage" {
  source = "./modules/storage"

  s3_bucket_name = var.s3_bucket_name
  project_tag    = var.project_tag
}

module "database" {
  source = "./modules/database"

  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  web_sg_id          = module.compute.web_sg_id
  db_username        = var.db_username
  db_password        = var.db_password
  project_tag        = var.project_tag
}
