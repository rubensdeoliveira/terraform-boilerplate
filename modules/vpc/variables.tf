variable "vpc_name" {
  description = "The name of the VPC service"
}

variable "vpc_region" {
  description = "The region where the network will be created"
}

variable "vpc_subnets" {
  description = "A list of subnets"
  type = list(object({
    name = string
    cidr = string
  }))
}

