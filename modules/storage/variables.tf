variable "storage_name" {
  description = "Name of the bucket in Google Cloud Platform"
}

variable "storage_location" {
  description = "Region of the Google Cloud Platform"
}

variable "storage_can_destroy" {
  description = "Can destroy the bucket or not"
  type        = bool
}