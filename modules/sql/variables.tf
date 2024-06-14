variable "postgres_name" {
  description = "Name of the PostgreSQL instance"
}

variable "postgres_database_version" {
  description = "Version of the PostgreSQL database"
}

variable "postgres_region" {
  description = "Region where the PostgreSQL instance will be deployed"
}

variable "postgres_tier" {
  description = "Tier of the PostgreSQL instance"
}

variable "postgres_vpc_self_link" {
  description = "Self-link of the VPC network for the PostgreSQL instance"
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

variable "postgres_can_destroy" {
  description = "Can destroy the postgres or not"
  type        = bool
}