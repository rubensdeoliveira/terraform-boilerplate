output "vpc_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "vpc_self_link" {
  description = "The self link of the VPC network"
  value       = google_compute_network.vpc.self_link
}

output "vpc_id" {
  description = "The self link of the VPC network"
  value       = google_compute_network.vpc.id
}

output "vpc_subnet" {
  description = "The self link of the VPC network"
  value       = google_compute_subnetwork.subnetwork
}

output "vpc_subnet_connector" {
  description = "Connector for the backend subnet"
  value       = google_vpc_access_connector.subnet_connector.name
}

