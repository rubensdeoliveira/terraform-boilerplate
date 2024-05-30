resource "google_storage_bucket" "terraform_state" {
  name                     = "flow-roll-bucket-state"
  location                 = var.region
  force_destroy            = false
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
}