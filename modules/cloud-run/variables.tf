variable "cloud_run_project" {
  description = "Project ID where the Cloud Run service will be deployed"
}

variable "cloud_run_name" {
  description = "Name of the Cloud Run service"
}

variable "cloud_run_location" {
  description = "Location where the Cloud Run service will be deployed"
}

variable "cloud_run_subnet_connector" {
  description = "Subnet connector for the Cloud Run service"
  type        = string
}

variable "cloud_run_docker_image" {
  description = "Docker image for the Cloud Run service"
}

variable "cloud_run_memory" {
  description = "Memory allocation for the Cloud Run service"
}

variable "cloud_run_cpu" {
  description = "CPU allocation for the Cloud Run service"
}

variable "cloud_run_port" {
  description = "Port number for the Cloud Run service"
  type        = number
}

variable "cloud_run_associated_service_account_id" {
  description = "Service account associated with the Cloud Run service"
}

variable "cloud_run_min_instances" {
  description = "Minimum number of instances for the Cloud Run service"
}

variable "cloud_run_max_instances" {
  description = "Minimum number of instances for the Cloud Run service"
}

variable "cloud_run_env" {
  description = "Environment variables for the Cloud Run service"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "cloud_run_type" {
  description = "Name of the VPC for the Cloud Run service"
  type        = string
  validation {
    condition     = contains(["frontend", "backend"], var.cloud_run_type)
    error_message = "The cloud_run_type must be either 'frontend' or 'backend'."
  }
}