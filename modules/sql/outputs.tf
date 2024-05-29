output "database_url" {
  value       = "postgresql://${google_sql_user.user.name}:${google_sql_user.user.password}@${google_sql_database_instance.sql.private_ip_address}/${google_sql_database.db.name}"
  description = "Database connection string"
}