# Enable APIS
module "api" {
  source = "../api"

  api_services = var.api_services
}

# Service Account
module "service_accounts" {
  source = "../service-account"

  service_account_accounts   = var.service_account_accounts
  service_account_project_id = var.project_id
}

# Cloud Storage
module "storage" {
  source = "../storage"

  storage_location    = var.region
  storage_can_destroy = var.can_destroy_resources
  storage_name        = var.storage_name
}

# Firestore
module "firestore" {
  depends_on = [module.api]
  source     = "../firestore"

  firestore_can_destroy = var.can_destroy_resources
  firestore_name        = var.firestore_name
}

# VPC and subnets
module "vpc" {
  depends_on = [module.api]
  source     = "../vpc"

  vpc_region  = var.region
  vpc_name    = var.vpc_name
  vpc_subnets = var.vpc_subnets
}

# Cloud SQL (postgres)
module "sql" {
  depends_on = [module.vpc]
  source     = "../sql"

  postgres_vpc_self_link    = module.vpc.vpc_self_link
  postgres_region           = var.region
  postgres_name             = var.postgres_name
  postgres_database_version = var.postgres_database_version
  postgres_tier             = var.postgres_tier
  postgres_db               = var.postgres_db
  postgres_user             = var.postgres_user
  postgres_password         = var.postgres_password
}

# Memorystore for Redis
module "redis" {
  depends_on = [module.vpc]
  source     = "../redis"

  redis_vpc_id         = module.vpc.vpc_id
  redis_region         = var.region
  redis_name           = var.redis_name
  redis_tier           = var.redis_tier
  redis_memory_size_gb = var.redis_memory_size_gb
  redis_version        = var.redis_version
  redis_display_name   = var.redis_name
}

# Cloud Run (backend)
module "cloud_runs" {
  depends_on = [module.sql]
  source     = "../cloud-run"

  for_each = { for i in var.cloud_runs : i.name => i }

  cloud_run_location                      = var.region
  cloud_run_subnet1_connector             = module.vpc.vpc_subnet1_connector
  cloud_run_name                          = each.value.name
  cloud_run_docker_image                  = each.value.docker_image
  cloud_run_memory                        = each.value.memory
  cloud_run_cpu                           = each.value.cpu
  cloud_run_port                          = each.value.port
  cloud_run_allowed_service_account_ids   = each.value.allowed_service_account_ids
  cloud_run_associated_service_account_id = each.value.associated_service_account_id
  cloud_run_min_instances                 = each.value.min_instances
  cloud_run_max_instances                 = each.value.max_instances
  cloud_run_allow_all_users               = each.value.allow_all_users
  cloud_run_env = each.value.add_database_url == true ? concat(each.value.env, [
    {
      name  = "DATABASE_URL"
      value = module.sql.database_url
    }
  ]) : each.value.env
}

# Google Cloud Monitoring
