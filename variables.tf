variable "region" {
  default = "eu-central-1"
}

variable "bucket_name" {
  default = "static-website-christosd"
  validation {
    condition     = can(regex("^static-website-christosd$", var.bucket_name))
    error_message = "${var.bucket_name} must match exactly static-website-christosd"
  }
}

locals {
  url = aws_s3_bucket_website_configuration.static-website-bucket.website_endpoint
}

