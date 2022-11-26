terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_auth_file)
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
