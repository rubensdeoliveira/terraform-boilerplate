# API
variable "api_services" {
  type        = list(string)
  description = "List of API services to enable"
}

# Service Account
variable "service_account_accounts" {
  description = "Service accounts for the Cloud Run service"
  type = list(object({
    id           = string
    display_name = string
    roles        = list(string)
  }))
}

# Shared
variable "project_id" {
  description = "Project ID"
}

variable "project_name" {
  description = "Project name"
}

variable "region" {
  description = "Region of the Google Cloud Platform"
}

variable "can_destroy_resources" {
  description = "Can destroy the resources or not"
  type        = bool
}

variable "enviroment" {
  description = "Enviroment of the Google Cloud Platform"
}

# VPC and subnets
variable "vpc_subnets" {
  description = "A list of subnets"
  type = list(object({
    name = string
    cidr = string
  }))
}

# Cloud SQL (postgres)
variable "postgres_database_version" {
  description = "Version of the PostgreSQL database"
}

variable "postgres_tier" {
  description = "Tier of the PostgreSQL instance"
}

variable "postgres_db" {
  description = "Name of the PostgreSQL database"
}

variable "postgres_user" {
  description = "Username for accessing the PostgreSQL database"
}

variable "postgres_password" {
  description = "Password for accessing the PostgreSQL database"
}

# Memorystore for Redis
variable "redis_tier" {
  description = "Redis tier"
}

variable "redis_memory_size_gb" {
  description = "Redis memory size in GB"
  type        = number
}

variable "redis_version" {
  description = "Redis version"
}

# Cloud Run
variable "cloud_runs" {
  description = "List of Cloud Run configurations"
  type = list(object({
    name                          = string
    docker_image                  = string
    memory                        = string
    add_database_url              = bool
    cpu                           = number
    port                          = number
    allowed_service_account_ids   = list(string)
    associated_service_account_id = string
    allow_all_users               = bool
    env = list(object({
      name  = string
      value = string
    }))
  }))
}