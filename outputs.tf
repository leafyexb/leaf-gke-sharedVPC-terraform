output "cluster_name" {
  value       = google_container_cluster.primary.name
  description = "The name of the deployed GKE cluster."
}

output "cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "The IP address of the GKE cluster control plane."
}

output "cluster_ca_certificate" {
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  description = "The public certificate authority of the cluster control plane (base64 encoded)."
  sensitive   = true
}

output "vpc_self_link" {
  value       = google_compute_network.shared_vpc.self_link
  description = "The self link of the VPC network created in the host project."
}

output "subnet_self_link" {
  value       = google_compute_subnetwork.gke_subnet.self_link
  description = "The self link of the subnet created in the host project."
}

output "cluster_name_2" {
  value       = google_container_cluster.secondary.name
  description = "The name of the second GKE cluster in us-west1."
}

output "cluster_endpoint_2" {
  value       = google_container_cluster.secondary.endpoint
  description = "The IP address of the second GKE cluster control plane."
}

output "cluster_ca_certificate_2" {
  value       = google_container_cluster.secondary.master_auth[0].cluster_ca_certificate
  description = "The public certificate authority of the second cluster control plane (base64 encoded)."
  sensitive   = true
}

output "subnet_self_link_2" {
  value       = google_compute_subnetwork.gke_subnet_2.self_link
  description = "The self link of the second subnet created in the host project."
}

