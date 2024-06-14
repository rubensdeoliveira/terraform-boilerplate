resource "google_sql_database_instance" "sql" {
  name             = var.postgres_name
  database_version = var.postgres_database_version
  region           = var.postgres_region

  settings {
    tier = var.postgres_tier

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.postgres_vpc_self_link
    }
  }

  deletion_protection = var.postgres_can_destroy ? false : true
}

resource "google_sql_database" "db" {
  name     = var.postgres_db
  instance = google_sql_database_instance.sql.name
}

resource "google_sql_user" "user" {
  name     = var.postgres_user
  instance = google_sql_database_instance.sql.name
  password = var.postgres_password
}