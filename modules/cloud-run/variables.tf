variable "cloud_run_name" {
  description = "Name of the Cloud Run service"
}

variable "cloud_run_location" {
  description = "Location where the Cloud Run service will be deployed"
}

variable "cloud_run_subnet1_connector" {
  description = "Subnet connector for the Cloud Run service"
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

variable "cloud_run_allowed_service_account_ids" {
  type        = list(string)
  description = "Service accounts allowed to access the Cloud Run service"
  default = [
    "allUsers"
  ]
}

variable "cloud_run_associated_service_account_id" {
  description = "Service account associated with the Cloud Run service"
}

variable "cloud_run_allow_all_users" {
  description = "Allow all users to access the Cloud Run service"
  type        = bool
}

variable "cloud_run_env" {
  description = "Environment variables for the Cloud Run service"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}