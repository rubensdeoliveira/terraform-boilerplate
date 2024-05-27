terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.29.1"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}
