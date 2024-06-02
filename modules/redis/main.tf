resource "google_redis_instance" "redis" {
  name           = var.redis_name
  region         = var.redis_region
  tier           = var.redis_tier
  memory_size_gb = var.redis_memory_size_gb

  authorized_network = var.redis_vpc_id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  redis_version = var.redis_version
  display_name  = var.redis_display_name

  lifecycle {
    prevent_destroy = false //alterar para true
  }
}