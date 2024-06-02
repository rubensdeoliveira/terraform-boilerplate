# Enable APIS
module "main" {
  source = "../modules/main"

  api_services              = var.api_services
  region                    = var.region
  can_destroy_resources     = var.can_destroy_resources
  storage_name              = "${var.project_name}-storage-${var.enviroment}"
  firestore_name            = "${var.project_name}-firestore-${var.enviroment}"
  vpc_name                  = "${var.project_name}-vpc-${var.enviroment}"
  vpc_subnets               = var.vpc_subnets
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
  cloud_run_backends        = var.cloud_run_backends
  cloud_run_frontends       = var.cloud_run_frontends
}
