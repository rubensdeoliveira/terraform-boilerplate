variable "service_name" {
  description = "Nome do serviço Cloud Run"
}

variable "service_region" {
  description = "Região do Google Cloud Platform"
}

variable "postgres_version" {
  description = "Versão do PostgreSQL"
}

variable "is_prd_enviroment" {
  description = "Se o ambiente é de produção ou não"
  type        = bool
}

variable "vpc_self_link" {
  description = "Link para a VPC"
}

variable "postgres_db" {
  description = "Nome do banco de dados"
}

variable "postgres_user" {
  description = "Nome do usuário do banco de dados"
}

variable "postgres_password" {
  description = "Senha do usuário do banco de dados"
}