data "google_storage_bucket" "storage" {
  name = "${var.storage_bucket_name}-${terraform.workspace}"
}