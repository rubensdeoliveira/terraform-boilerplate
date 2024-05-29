resource "google_redis_instance" "redis" {
  name           = "${var.service_name}-${terraform.workspace}"
  region         = var.service_region
  tier           = var.is_prd_enviroment ? "BASIC" : "STANDARD_HA"
  memory_size_gb = var.is_prd_enviroment ? 2 : 1

  authorized_network = var.vpc_id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  redis_version = var.redis_version
  display_name  = var.redis_display_name

  lifecycle {
    prevent_destroy = true
  }
}