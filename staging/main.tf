# Enable APIS
module "main" {
  source = "../modules/main"

  api_services              = var.api_services
  service_account_accounts  = var.service_account_accounts
  region                    = var.region
  project_id                = var.project_id
  can_destroy_resources     = var.can_destroy_resources
  storage_name              = "${var.project_name}-storage-${var.enviroment}-2"
  firestore_name            = "${var.project_name}-firestore-${var.enviroment}"
  vpc_name                  = "${var.project_name}-vpc-${var.enviroment}"
  postgres_name             = "${var.project_name}-postgres-${var.enviroment}"
  postgres_database_version = var.postgres_database_version
  postgres_tier             = var.postgres_tier
  postgres_db               = var.postgres_db
  postgres_user             = var.postgres_user
  postgres_password         = var.postgres_password
  redis_name                = "${var.project_name}-redis-${var.enviroment}"
  redis_tier                = var.redis_tier
  redis_memory_size_gb      = var.redis_memory_size_gb
  redis_version             = var.redis_version
  cloud_runs                = var.cloud_runs
}
