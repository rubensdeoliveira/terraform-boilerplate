# data "google_service_account" "associated_service_account" {
#   account_id = var.cloud_run_associated_service_account_id
# }

resource "google_service_account" "account" {
  account_id   = "cloud-run-invoker"
  display_name = "Cloud Run Invoker"
  project      = var.cloud_run_project
}

resource "google_cloud_run_service" "run" {
  name     = var.cloud_run_name
  location = var.cloud_run_location

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" : var.cloud_run_min_instances
        "autoscaling.knative.dev/maxScale" : var.cloud_run_max_instances
        "run.googleapis.com/vpc-access-connector" : var.cloud_run_subnet_connector
        "run.googleapis.com/vpc-access-egress" : "private-ranges-only",
      }
    }

    spec {
      containers {
        image = "${var.cloud_run_docker_image}:latest"

        resources {
          limits = {
            memory = var.cloud_run_memory
            cpu    = var.cloud_run_cpu
          }
        }

        ports {
          container_port = var.cloud_run_port
        }

        dynamic "env" {
          for_each = var.cloud_run_env
          content {
            name  = env.value.name
            value = env.value.value
          }
        }
      }
      # service_account_name = data.google_service_account.associated_service_account.email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# resource "google_cloud_run_service_iam_member" "no_auth_invoker" {
#   depends_on = [google_cloud_run_service.run]
#   location   = var.cloud_run_location
#   service    = var.cloud_run_name
#   role       = "roles/run.invoker"
#   member     = "allUsers"
# }

resource "google_api_gateway_api" "api" {
  provider     = google-beta
  api_id       = "my-api"
  display_name = "My API"
  project      = var.cloud_run_project
}

resource "google_api_gateway_api_config" "api_config" {
  provider      = google-beta
  api           = google_api_gateway_api.api.api_id
  api_config_id = "my-config"
  display_name  = "My API Config"
  project       = var.cloud_run_project

  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("openapi.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "gateway" {
  provider     = google-beta
  api_config   = google_api_gateway_api_config.api_config.id
  gateway_id   = "my-gateway"
  display_name = "My Gateway"
  project      = var.cloud_run_project
  region       = var.cloud_run_location
}

resource "google_project_iam_member" "api_gateway_invoker" {
  project = var.cloud_run_project
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.account.email}"
}

resource "google_cloud_run_service_iam_member" "invoker" {
  location = google_cloud_run_service.run.location
  project  = google_cloud_run_service.run.project
  service  = google_cloud_run_service.run.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.account.email}"
}

resource "google_project_service" "api" {
  service            = google_api_gateway_api.api.managed_service
  disable_on_destroy = false
}