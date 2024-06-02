variable "redis_name" {
  description = "Redis service name"
}

variable "redis_region" {
  description = "Redis region"
}

variable "redis_tier" {
  description = "Redis tier"
}

variable "redis_memory_size_gb" {
  description = "Redis memory size in GB"
  type        = number
}

variable "redis_vpc_id" {
  description = "VPC ID"
}

variable "redis_version" {
  description = "Redis version"
}

variable "redis_display_name" {
  description = "Redis display name"
}


