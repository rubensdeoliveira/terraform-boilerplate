resource "google_compute_network" "vpc" {
  name = var.vpc_name
}

resource "google_compute_subnetwork" "subnetwork" {
  name                     = "subnet-backend"
  ip_cidr_range            = "10.0.0.0/16"
  region                   = var.vpc_region
  network                  = google_compute_network.vpc.name
  private_ip_google_access = true
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_vpc_access_connector" "subnet_connector" {
  name          = "subnet-connector-backend"
  network       = google_compute_network.vpc.name
  region        = var.vpc_region
  ip_cidr_range = "10.8.0.0/28"
}

