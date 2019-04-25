terraform {
  required_version = ">= 0.11.0"
  backend "gcs" {
    bucket      = "ps-dev-201405-kearos-terraform-state"
    prefix      = "dev"
  }
}