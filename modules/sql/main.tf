resource "google_sql_database_instance" "sql" {
  name             = "${var.service_name}-${terraform.workspace}"
  database_version = var.postgres_version
  region           = var.service_region

  settings {
    tier = var.is_prd_enviroment ? "db-g1-small" : "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.vpc_self_link
    }
  }
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