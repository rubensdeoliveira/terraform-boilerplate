data "google_service_account" "associated_service_account" {
  account_id = var.cloud_run_associated_service_account_id
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

resource "google_cloud_run_service_iam_member" "no_auth_invoker" {
  depends_on = [google_cloud_run_service.run]
  location   = var.cloud_run_location
  service    = var.cloud_run_name
  role       = "roles/run.invoker"
  member     = "allUsers"
}

