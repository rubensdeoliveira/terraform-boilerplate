terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.29.1"
    }
  }
  backend "gcs" {
    bucket = "flow-roll-bucket-state"
    prefix = "terraform"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# resource "google_storage_bucket" "terraform_state" {
#   name                     = "flow-roll-bucket-tfstate"
#   location                 = var.region
#   force_destroy            = false
#   public_access_prevention = "enforced"

#   versioning {
#     enabled = true
#   }
# }