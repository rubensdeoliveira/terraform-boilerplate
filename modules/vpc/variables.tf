variable "service_name" {
  description = "The name of the VPC service"
  type        = string
}

variable "subnets" {
  description = "A list of subnets"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "service_region" {
  description = "The region where the network will be created"
  type        = string
}

variable "project_id" {
  description = "The project ID"
  type        = string
}