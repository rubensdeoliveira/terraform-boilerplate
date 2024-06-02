data "google_service_account" "allowed_service_accounts" {
  for_each   = toset(var.cloud_run_allowed_service_account_ids)
  account_id = each.value
}

data "google_service_account" "associated_service_account" {
  account_id = var.cloud_run_associated_service_account_id
}

resource "google_cloud_run_service" "run" {
  name     = var.cloud_run_name
  location = var.cloud_run_location

  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" : var.cloud_run_subnet1_connector
        "run.googleapis.com/vpc-access-egress" : "private-ranges-only"
        "autoscaling.knative.dev/minScale" = var.cloud_run_min_instances
        "autoscaling.knative.dev/maxScale" = var.cloud_run_max_instances
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
      service_account_name = data.google_service_account.associated_service_account.email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

}

locals {
  members = var.cloud_run_allow_all_users ? ["allUsers"] : [for id in var.cloud_run_allowed_service_account_ids : "serviceAccount:${data.google_service_account.allowed_service_accounts[id].email}"]
}

data "google_iam_policy" "auth" {
  binding {
    role    = "roles/run.invoker"
    members = local.members
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.run.location
  project  = google_cloud_run_service.run.project
  service  = google_cloud_run_service.run.name

  policy_data = data.google_iam_policy.auth.policy_data
}