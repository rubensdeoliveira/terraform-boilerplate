# API
variable "api_services" {
  type        = list(string)
  description = "List of API services to enable"
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

# Cloud Run (backend)
variable "cloud_run_backends" {
  description = "List of Cloud Run configurations"
  type = list(object({
    name         = string
    docker_image = string
    memory       = string
    cpu          = number
    port         = number
    env = list(object({
      name  = string
      value = string
    }))
  }))
}

# Cloud Run (frontend)
variable "cloud_run_frontends" {
  description = "List of Cloud Run configurations"
  type = list(object({
    name         = string
    docker_image = string
    memory       = string
    cpu          = number
    port         = number
    env = list(object({
      name  = string
      value = string
    }))
  }))
}