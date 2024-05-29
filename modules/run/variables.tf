variable "service_name" {
  description = "Nome do serviço Cloud Run"
}

variable "service_region" {
  description = "Região do Google Cloud Platform"
}

variable "docker_image" {
  description = "Imagem Docker a ser utilizada no Cloud Run"
}

variable "subnet1_connector" {
  description = "Conector de rede VPC"
}

variable "is_prd_enviroment" {
  description = "Se o ambiente é de produção ou não"
  type        = bool
}

variable "port" {
  description = "Conector de rede VPC"
  default     = 3000
  type        = number
}

variable "env_vars" {
  description = "List of environment variables"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}