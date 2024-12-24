variable "website_url" {
  type = string
}

#"http://www.static-website-christosd.s3-website.eu-central-1.amazonaws.com"

data "http" "main" {
  url = var.website_url
}