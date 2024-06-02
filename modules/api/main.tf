resource "google_project_service" "api" {
  for_each           = toset(var.api_services)
  service            = each.value
  disable_on_destroy = false
}