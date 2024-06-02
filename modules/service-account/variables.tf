variable "service_account_accounts" {
  description = "Service accounts for the Cloud Run service"
  type = list(object({
    id           = string
    display_name = string
    roles        = list(string)
  }))
}

variable "service_account_project_id" {
  description = "The project id for the service account"
}