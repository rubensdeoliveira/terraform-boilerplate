resource "google_storage_bucket" "storage" {
  name          = "${var.service_name}-${terraform.workspace}"
  location      = var.service_region
  force_destroy = var.is_prd_enviroment ? false : true

  public_access_prevention = "enforced"

  labels = {
    iac = "terraform"
    env = terraform.workspace
  }
}