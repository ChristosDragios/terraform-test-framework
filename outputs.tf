output "homepage_url" {
  value = aws_s3_bucket_website_configuration.static-website-bucket.website_endpoint
}
/*
output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "resource_group_name" {
  value = azurerm_storage_account.main.resource_group_name
}
*/