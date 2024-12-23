# Test different inputs for the storage account
run "check_html_file" {
  command = plan

  assert {
    condition     = resource.aws_s3_bucket_website_configuration.static-website-bucket.index_document[0].suffix == "index.html"
    error_message = "html file is not properly parsed"
  }
}

run "acl_public" {
  command = plan

  assert {
    condition     = resource.aws_s3_bucket_versioning.static-website-bucket.versioning_configuration[0].status == "Enabled"
    error_message = "S3 bucket '${resource.aws_s3_bucket.static-website-bucket.bucket}' does not have versionning enabled."
  }
}

run "bucket_name" {
  command = plan

  variables {
    bucket_name = "ThisIsAWrongBucketName"
  }

  expect_failures = [
    var.bucket_name,
  ]
}