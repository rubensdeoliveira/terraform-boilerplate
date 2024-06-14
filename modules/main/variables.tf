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
variable "region" {
  description = "Region of the Google Cloud Platform"
}

variable "can_destroy_resources" {
  description = "Can destroy the resources or not"
  type        = bool
}

variable "project_id" {
  description = "The project id"
}

# Cloud Storage
variable "storage_name" {
  description = "Name of the Cloud Storage bucket"
}

# Firestore
variable "firestore_name" {
  description = "Name of the Firestore database"
}

# VPC and subnets
variable "vpc_name" {
  description = "Name of the VPC"
}

# Cloud SQL (postgres)
variable "postgres_name" {
  description = "Name of the PostgreSQL instance"
}

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
variable "redis_name" {
  description = "Name of the Redis instance"
}

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
    associated_service_account_id = string
    min_instances                 = string
    max_instances                 = string
    type                          = string
    env = list(object({
      name  = string
      value = string
    }))
  }))
}