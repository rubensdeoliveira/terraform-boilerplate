variable "project_id" {
  description = "ID do projeto no Google Cloud Platform"
}

variable "project_name" {
  description = "Nome do projeto no Google Cloud Platform"
}

variable "region" {
  description = "Região do Google Cloud Platform"
}

variable "postgres_version" {
  description = "Versão do banco de dados"
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

variable "production_workspace_name" {
  description = "Nome do workspace de produção"
}

variable "redis_version" {
  description = "Versão do banco de dados"
}

variable "vpc_subnets" {
  description = "A list of subnets"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "env_vars_back" {
  description = "List of environment variables"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "env_vars_front" {
  description = "List of environment variables"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}