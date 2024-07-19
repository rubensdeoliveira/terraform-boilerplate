variable "firestore_name" {
  description = "Firestore database name"
}

variable "firestore_location" {
  description = "Firestore database location"
}

variable "firestore_can_destroy" {
  description = "Can destroy the firestore or not"
  type        = bool
}