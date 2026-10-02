locals {
  name_prefix = var.cluster_name

  tags = {
    Project     = var.cluster_name
    Environment = "production"
    ManagedBy   = "terraform"
  }

  common_node_labels = {
    "workload.eks.amazonaws.com/lifecycle" = "managed"
  }
}
