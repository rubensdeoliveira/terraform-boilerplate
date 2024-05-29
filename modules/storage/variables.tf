variable "service_name" {
  description = "Nome do bucket no Google Cloud Platform"
}

variable "service_region" {
  description = "Região do Google Cloud Platform"
}

variable "is_prd_enviroment" {
  description = "Se o ambiente é de produção ou não"
  type        = bool
}