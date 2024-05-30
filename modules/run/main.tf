resource "google_cloud_run_service" "run" {
  name     = "${var.service_name}-${terraform.workspace}"
  location = var.service_region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" : var.subnet1_connector
        "run.googleapis.com/vpc-access-egress" : "private-ranges-only"
      }
    }
    spec {
      containers {
        image = var.is_prd_enviroment ? "${var.docker_image_prd}:latest" : "${var.docker_image_stg}:latest"

        resources {
          limits = {
            memory = var.is_prd_enviroment ? "512Mi" : "256Mi"
            cpu    = var.is_prd_enviroment ? "2" : "1"
          }
        }

        ports {
          container_port = var.port
        }

        dynamic "env" {
          for_each = var.env_vars
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