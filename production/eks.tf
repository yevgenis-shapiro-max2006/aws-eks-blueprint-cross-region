module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.cluster_version

  endpoint_private_access     = true
  endpoint_public_access      = var.cluster_endpoint_public_access
  endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  authentication_mode = "API_AND_CONFIG_MAP"
  enable_irsa         = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = false

  enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  encryption_config = {
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }

  access_entries = {
    for idx, principal_arn in var.cluster_admin_principal_arns :
    "admin-${idx}" => {
      principal_arn = principal_arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  cluster_addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent = true
    }

    eks-pod-identity-agent = {
      most_recent = true
    }

    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    system = {
      name           = "${var.cluster_name}-system"
      instance_types = var.system_instance_types
      capacity_type  = "ON_DEMAND"
      min_size       = var.system_min_size
      desired_size   = var.system_desired_size
      max_size       = var.system_max_size
      subnet_ids     = module.vpc.private_subnets

      labels = {
        "node-role.kubernetes.io/system" = "true"
      }

      taints = {
        critical-addons = {
          key    = "CriticalAddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      }

      update_config = {
        max_unavailable_percentage = 33
      }
    }

    general = {
      name           = "${var.cluster_name}-general"
      instance_types = var.general_instance_types
      capacity_type  = "ON_DEMAND"
      min_size       = var.general_min_size
      desired_size   = var.general_desired_size
      max_size       = var.general_max_size
      subnet_ids     = module.vpc.private_subnets

      labels = {
        workload = "general"
      }

      update_config = {
        max_unavailable_percentage = 33
      }
    }
  }
}
