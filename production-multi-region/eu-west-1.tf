module "eks_eu_west_1" {
  source = "./modules/regional-eks"
  providers = { aws = aws.eu_west_1 }
  cluster_name = "regional-eks-eu-west-1"
  aws_region = "eu-west-1"
  availability_zones = ["eu-west-1a","eu-west-1b","eu-west-1c"]
  vpc_cidr = "10.10.0.0/16"
  public_subnet_cidrs = ["10.10.0.0/20","10.10.16.0/20","10.10.32.0/20"]
  private_subnet_cidrs = ["10.10.128.0/20","10.10.144.0/20","10.10.160.0/20"]
  cluster_version = var.cluster_version
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_admin_principal_arns = var.cluster_admin_principal_arns
  enable_vpc_flow_logs = var.enable_vpc_flow_logs
  enable_vpc_endpoints = var.enable_vpc_endpoints
  system_instance_types = var.system_instance_types
  general_instance_types = var.general_instance_types
  system_min_size = var.system_min_size
  system_desired_size = var.system_desired_size
  system_max_size = var.system_max_size
  general_min_size = var.general_min_size
  general_desired_size = var.general_desired_size
  general_max_size = var.general_max_size
  node_root_volume_size = var.node_root_volume_size
  node_root_volume_iops = var.node_root_volume_iops
  node_root_volume_throughput = var.node_root_volume_throughput
}