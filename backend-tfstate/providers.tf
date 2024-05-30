terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.29.1"
    }
  }
  # backend "gcs" {
  #   bucket = "flow-roll-bucket-backend-state"
  #   prefix = "terraform"
  # }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "terraform_backend_state" {
  name                     = "flow-roll-bucket-backend-state"
  location                 = var.region
  force_destroy            = false
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
}