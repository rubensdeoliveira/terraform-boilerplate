# Cloud Storage
module "storage" {
  source            = "./modules/storage"
  service_name      = "${var.project_name}-bucket"
  service_region    = var.region
  is_prd_enviroment = terraform.workspace == var.production_workspace_name
}

# Firestore

# VPC and subnets
module "vpc" {
  source         = "./modules/vpc"
  service_name   = "${var.project_name}-vpc"
  service_region = var.region
  subnets        = var.vpc_subnets
  project_id     = var.project_id
}

# Cloud SQL (postgres)
module "sql" {
  depends_on        = [module.vpc]
  source            = "./modules/sql"
  service_name      = "${var.project_name}-sql"
  service_region    = var.region
  is_prd_enviroment = terraform.workspace == var.production_workspace_name
  postgres_version  = var.postgres_version
  postgres_db       = var.postgres_db
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
  vpc_self_link     = module.vpc.vpc_self_link
}

# Memorystore for Redis

# Cloud Run (backend)
module "run" {
  depends_on        = [module.sql]
  source            = "./modules/run"
  service_name      = "${var.project_name}-backend"
  service_region    = var.region
  docker_image      = var.docker_image
  subnet1_connector = module.vpc.subnet1_connector
  is_prd_enviroment = terraform.workspace == var.production_workspace_name
  port              = var.cloud_run_port
  env_vars = concat(var.env_vars_back, [
    {
      name  = "DATABASE_URL"
      value = module.sql.database_url
    }
  ])
}

# Cloud Run (frontend)
# module "run" {
#   source         = "./modules/run"
#   service_name   = "${var.project_name}-backend"
#   service_region = var.region
#   docker_image   = "gcr.io/${var.project_id}/${var.project_name}-container-${terraform.workspace}"
# }

# Google Cloud Monitoring
