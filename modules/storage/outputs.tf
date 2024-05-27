output "storage_domain_url" {
  value       = data.google_storage_bucket.storage.self_link
  sensitive   = false
  description = "The domain URL of the storage bucket"
}