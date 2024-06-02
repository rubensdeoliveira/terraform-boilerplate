resource "google_cloud_run_service" "run" {
  name     = var.cloud_run_name
  location = var.cloud_run_location

  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" : var.cloud_run_subnet1_connector
        "run.googleapis.com/vpc-access-egress" : "private-ranges-only"
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
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.run.location
  project  = google_cloud_run_service.run.project
  service  = google_cloud_run_service.run.name

  policy_data = data.google_iam_policy.noauth.policy_data
}