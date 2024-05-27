module "storage" {
  source              = "./modules/storage"
  storage_bucket_name = "${var.project_name}-bucket"
  region              = var.region
}