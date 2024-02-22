# ##################################################
# # This was created via Bard/Gemini.
# ##################################################
# # takes quite some time. 8m10s and counting:
# # google_container_cluster.primary: Still creating... [8m0s elapsed]
# # google_container_cluster.primary: Still creating... [8m10s elapsed]
# # ..
# # google_container_cluster.primary: Still creating... [11m10s elapsed]
# ##################################################

# # Create a new VPC
# # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
# # Optional: If you want to create a new VPC
# # resource "google_compute_network" "vpc_network" {
# #   name                    = "my-gke-vpc"
# #   auto_create_subnetworks = false
# # }

# # # Optional: If you want to create a subnet
# # resource "google_compute_subnetwork" "subnet" {
# #   name          = "my-gke-subnet"
# #   network       = google_compute_network.vpc_network.id
# #   ip_cidr_range = "10.10.0.0/16"
# #   region        = var.region
# # }

# # https://github.com/hashicorp/learn-terraform-provision-gke-cluster/blob/main/vpc.tf

# # VPC
# resource "google_compute_network" "vpc" {
#   name                    = "${var.project_id}-vpc"
#   auto_create_subnetworks = "false"
# }

# # Subnet
# resource "google_compute_subnetwork" "subnet" {
#   name          = "${var.project_id}-subnet"
#   region        = var.region
#   network       = google_compute_network.vpc.name
#   ip_cidr_range = "10.10.0.0/24"
# }


# # Create the GKE cluster
# resource "google_container_cluster" "primary" {
#   name               = "my-small-gke-cluster"
#   location           = var.zone
#   #network            = google_compute_network.vpc_network.name  # If using a new VPC
#   #subnetwork         = google_compute_subnetwork.subnet.name  # If using a new subnet
#   network    = google_compute_network.vpc.name
#   subnetwork = google_compute_subnetwork.subnet.name

#   # For a small cluster
#   initial_node_count = 1
#   remove_default_node_pool = true

#   # Add more configuration as needed (IP ranges, master auth, etc.)
# }

# # Optional: Create node pools
# resource "google_container_node_pool" "primary_preemptible_nodes" {
#   name       = "my-preemptible-node-pool"
#   location   = var.zone
#   cluster    = google_container_cluster.primary.name
#   node_count = 1

#   node_config {
#     preemptible  = true
#     machine_type = "e2-small"
#     # Other node config options
#   }
# }
