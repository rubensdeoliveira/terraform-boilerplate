resource "google_storage_bucket" "storage" {
  name     = "${var.project_name}-bucket-${terraform.workspace}"
  location = var.region

  public_access_prevention = "enforced"

  labels = {
    iac = "terraform"
    env = terraform.workspace
  }
}