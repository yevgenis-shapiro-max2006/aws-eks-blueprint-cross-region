variable "cluster_name" { type = string }
variable "aws_region" { type = string }
variable "cluster_version" { type = string }
variable "vpc_cidr" { type = string }
variable "availability_zones" { type = list(string) validation { condition = length(var.availability_zones) == 3 error_message = "Exactly three AZs are required." } }
variable "public_subnet_cidrs" { type = list(string) validation { condition = length(var.public_subnet_cidrs) == 3 error_message = "Exactly three public subnets are required." } }
variable "private_subnet_cidrs" { type = list(string) validation { condition = length(var.private_subnet_cidrs) == 3 error_message = "Exactly three private subnets are required." } }
variable "cluster_endpoint_public_access" { type = bool }
variable "cluster_endpoint_public_access_cidrs" { type = list(string) }
variable "cluster_admin_principal_arns" { type = list(string) }
variable "enable_vpc_flow_logs" { type = bool }
variable "enable_vpc_endpoints" { type = bool }
variable "system_instance_types" { type = list(string) }
variable "general_instance_types" { type = list(string) }
variable "system_min_size" { type = number }
variable "system_desired_size" { type = number }
variable "system_max_size" { type = number }
variable "general_min_size" { type = number }
variable "general_desired_size" { type = number }
variable "general_max_size" { type = number }
variable "node_root_volume_size" { type = number }
variable "node_root_volume_iops" { type = number }
variable "node_root_volume_throughput" { type = number }