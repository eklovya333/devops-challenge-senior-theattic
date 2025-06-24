terraform{
    required_providers{
        google = {
            source = "hashicorp/google"
            version = "6.40.0"
        }
    }
}


# provider configuration
provider "google" {
    project = var.project_id
    region = var.region
}

data "google_project" "existing" {
  project_id = var.project_id
}

# new project
#resource "google_project" "project_micro1"{
#    name = var.project_name
 #   project_id = var.project_id
#    billing_account = var.billing_account_id
#}

# required to create vm,s
resource "google_project_service" "compute_api" {
    project = data.google_project.existing.project_id
    service = "compute.googleapis.com"
}


# required to create GCP cluster
resource "google_project_service" "k8s_api" {
    project = data.google_project.existing.project_id
    service = "container.googleapis.com"
}

# network configuration for cluster
resource "google_compute_network" "k8s_network" {
    project = data.google_project.existing.project_id
    name = "cluster-network"
    auto_create_subnetworks = false
}

# subnetwork for cluster
resource "google_compute_subnetwork" "k8s_Subnet" {
    project = data.google_project.existing.project_id
    name = "cluster-subnetwork"
    network = google_compute_network.k8s_network.name
    ip_cidr_range = "10.0.0.0/27"
    region = var.region
}

resource "google_container_cluster" "cluster_micro1" {
    name = "cluster-test"
    project = data.google_project.existing.project_id
    location = var.zone
    initial_node_count = 1
    remove_default_node_pool = true
    network = google_compute_network.k8s_network.name
    subnetwork = google_compute_subnetwork.k8s_Subnet.name
}

resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
  project      = data.google_project.existing.project_id
}

resource "google_project_iam_member" "gke_node_sa_roles" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/container.nodeServiceAccount"
  ])

  project = data.google_project.existing.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_container_node_pool" "node_cluster_micro1" {
  name       = "node-pool-micro1"
  project    = data.google_project.existing.project_id
  location   = var.zone
  cluster    = google_container_cluster.cluster_micro1.name
  node_count = 1

  node_config {
    machine_type    = "e2-micro"
    disk_type       = "pd-standard"
    disk_size_gb    = 12
    service_account = google_service_account.gke_node_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
