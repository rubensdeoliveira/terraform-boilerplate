resource "google_compute_network" "vpc" {
  name = "${var.service_name}-${terraform.workspace}"
}

resource "google_compute_subnetwork" "subnetwork" {
  count         = length(var.subnets)
  name          = element(var.subnets, count.index).name
  ip_cidr_range = element(var.subnets, count.index).cidr
  region        = var.service_region
  network       = google_compute_network.vpc.name
}

resource "google_compute_firewall" "default" {
  name    = "${var.service_name}-firewall-${terraform.workspace}"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/8"]
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

resource "google_vpc_access_connector" "subnet1_connector" {
  name   = "subnet1-connector"
  region = var.service_region
  subnet {
    name = element(google_compute_subnetwork.subnetwork.*.name, 0)
  }
}

resource "google_vpc_access_connector" "subnet2_connector" {
  name   = "subnet2-connector"
  region = var.service_region
  subnet {
    name = element(google_compute_subnetwork.subnetwork.*.name, 1)
  }
}