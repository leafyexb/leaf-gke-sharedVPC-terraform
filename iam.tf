data "google_project" "service_project" {
  project_id = var.service_project_id
}

# The GKE Service Agent email format: service-PROJECT_NUMBER@container-engine-robot.iam.gserviceaccount.com
# The Cloud Services Service Account email format: PROJECT_NUMBER@cloudservices.gserviceaccount.com

# 1. Grant container.hostServiceAgentUser role to GKE Service Agent on the Host Project
resource "google_project_iam_member" "gke_host_service_agent" {
  project = var.host_project_id
  role    = "roles/container.hostServiceAgentUser"
  member  = "serviceAccount:service-${data.google_project.service_project.number}@container-engine-robot.iam.gserviceaccount.com"

  depends_on = [
    google_project_service.service_container
  ]
}

# 2. Grant compute.networkUser role to GKE Service Agent on the Shared VPC Subnet
resource "google_compute_subnetwork_iam_member" "gke_subnet_network_user" {
  project    = var.host_project_id
  region     = var.region
  subnetwork = google_compute_subnetwork.gke_subnet.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${data.google_project.service_project.number}@container-engine-robot.iam.gserviceaccount.com"

  depends_on = [
    google_project_service.service_container,
    google_compute_subnetwork.gke_subnet
  ]
}

# 3. Grant compute.networkUser role to Google APIs Service Account on the Shared VPC Subnet
resource "google_compute_subnetwork_iam_member" "apis_subnet_network_user" {
  project    = var.host_project_id
  region     = var.region
  subnetwork = google_compute_subnetwork.gke_subnet.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.google_project.service_project.number}@cloudservices.gserviceaccount.com"

  depends_on = [
    google_project_service.service_container,
    google_compute_subnetwork.gke_subnet
  ]
}

# 4. Grant compute.securityAdmin role to GKE Service Agent on the Host Project
# This is required for GKE to automatically create and manage VPC firewall rules in the Host Project.
resource "google_project_iam_member" "gke_host_security_admin" {
  project = var.host_project_id
  role    = "roles/compute.securityAdmin"
  member  = "serviceAccount:service-${data.google_project.service_project.number}@container-engine-robot.iam.gserviceaccount.com"

  depends_on = [
    google_project_service.service_container
  ]
}

# 5. Grant compute.networkUser role to GKE Service Agent on the second Shared VPC Subnet (us-west1)
resource "google_compute_subnetwork_iam_member" "gke_subnet_2_network_user" {
  project    = var.host_project_id
  region     = var.region_2
  subnetwork = google_compute_subnetwork.gke_subnet_2.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${data.google_project.service_project.number}@container-engine-robot.iam.gserviceaccount.com"

  depends_on = [
    google_project_service.service_container,
    google_compute_subnetwork.gke_subnet_2
  ]
}

# 6. Grant compute.networkUser role to Google APIs Service Account on the second Shared VPC Subnet (us-west1)
resource "google_compute_subnetwork_iam_member" "apis_subnet_2_network_user" {
  project    = var.host_project_id
  region     = var.region_2
  subnetwork = google_compute_subnetwork.gke_subnet_2.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.google_project.service_project.number}@cloudservices.gserviceaccount.com"

  depends_on = [
    google_project_service.service_container,
    google_compute_subnetwork.gke_subnet_2
  ]
}


