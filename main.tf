resource "aws_s3_bucket" "static-website-bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_object" "static-website-bucket" {
  bucket       = aws_s3_bucket.static-website-bucket.bucket
  key          = "static-website/index.html"           # S3 object key (path in the bucket)
  source       = "/Users/chrisd/Library/3E/index.html" # Local file path
  content_type = "text/html"
}

resource "aws_s3_bucket_ownership_controls" "static-website-bucket" {
  bucket = aws_s3_bucket.static-website-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static-website-bucket" {
  bucket = aws_s3_bucket.static-website-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "static-website-bucket" {
  depends_on = [
    aws_s3_bucket_public_access_block.static-website-bucket,
    aws_s3_bucket_ownership_controls.static-website-bucket,
  ]

  bucket = aws_s3_bucket.static-website-bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "static-website-bucket" {
  bucket = aws_s3_bucket.static-website-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "static-website-bucket" {
  bucket = aws_s3_bucket.static-website-bucket.id

  index_document {
    suffix = "index.html"
  }
}
