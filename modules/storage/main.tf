resource "google_storage_bucket" "storage" {
  name     = "${var.storage_bucket_name}-${terraform.workspace}"
  location = var.region

  public_access_prevention = "enforced"

  labels = {
    iac = "terraform"
    env = terraform.workspace
  }
}