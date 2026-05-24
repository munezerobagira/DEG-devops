resource "aws_s3_bucket" "assets" {
  bucket = var.s3_bucket_name

  force_destroy = true

  tags = {
    Name    = "vela-payments-assets"
    Project = var.project_tag
  }
}

resource "aws_s3_bucket_public_access_block" "assets_block" {
  bucket = aws_s3_bucket.assets.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "assets_versioning" {
  bucket = aws_s3_bucket.assets.id

  versioning_configuration {
    status = "Enabled"
  }
}