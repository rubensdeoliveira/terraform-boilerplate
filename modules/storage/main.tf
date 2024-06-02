resource "google_storage_bucket" "storage" {
  name                     = var.storage_name
  location                 = var.storage_location
  force_destroy            = var.storage_can_destroy
  public_access_prevention = "enforced"

  labels = {
    iac = "terraform"
  }
}