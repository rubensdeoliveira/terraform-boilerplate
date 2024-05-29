output "vpc_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "vpc_self_link" {
  description = "The self link of the VPC network"
  value       = google_compute_network.vpc.self_link
}

output "subnets" {
  description = "List of subnets"
  value       = google_compute_subnetwork.subnetwork
}

output "subnet1_connector" {
  value = google_vpc_access_connector.subnet1_connector.name
}

output "subnet2_connector" {
  value = google_vpc_access_connector.subnet2_connector.name
}