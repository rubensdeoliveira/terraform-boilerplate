terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.29.1"
    }
  }
  backend "gcs" {
    bucket = "flow-roll-state-production"
    prefix = "terraform"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

