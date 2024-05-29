variable "service_name" {
  description = "Nome do serviço Cloud Run"
}

variable "service_region" {
  description = "Região do Google Cloud Platform"
}

variable "is_prd_enviroment" {
  description = "Se o ambiente é de produção ou não"
  type        = bool
}

variable "redis_version" {
  description = "Versão do banco de dados"
}

variable "redis_display_name" {
  description = "Nome de exibição do banco de dados"
}

variable "vpc_id" {
  description = "ID da VPC"
}