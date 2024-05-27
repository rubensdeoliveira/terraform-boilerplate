data "google_storage_bucket" "storage" {
  name = "${var.project_name}-bucket-${terraform.workspace}"
}