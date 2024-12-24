run "check_site" {
  command = apply

variables {
    website_url = "http://www.static-website-christosd.s3-website.eu-central-1.amazonaws.com"
  }

  module {
    source = "./tests/loader"
  }

  assert {
    condition     = data.http.main.status_code == 200
    error_message = "Website ${var.website_url} returned the status code ${data.http.main.status_code}. Expected 200."
  }
}