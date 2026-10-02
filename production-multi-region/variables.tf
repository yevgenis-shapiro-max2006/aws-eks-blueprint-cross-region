variable "cluster_version" { type = string default = "1.33" }
variable "cluster_endpoint_public_access" { type = bool default = false }
variable "cluster_endpoint_public_access_cidrs" { type = list(string) default = [] }
variable "cluster_admin_principal_arns" { type = list(string) default = [] }
variable "enable_vpc_flow_logs" { type = bool default = true }
variable "enable_vpc_endpoints" { type = bool default = true }
variable "system_instance_types" { type = list(string) default = ["m6i.large"] }
variable "general_instance_types" { type = list(string) default = ["m6i.large", "m6a.large"] }
variable "system_min_size" { type = number default = 3 }
variable "system_desired_size" { type = number default = 3 }
variable "system_max_size" { type = number default = 6 }
variable "general_min_size" { type = number default = 3 }
variable "general_desired_size" { type = number default = 3 }
variable "general_max_size" { type = number default = 9 }
variable "node_root_volume_size" { type = number default = 100
  validation { condition = var.node_root_volume_size == 100 error_message = "Node root volume size must be exactly 100 GiB." } }
variable "node_root_volume_iops" { type = number default = 3000
  validation { condition = var.node_root_volume_iops >= 3000 && var.node_root_volume_iops <= 16000 error_message = "GP3 IOPS must be between 3000 and 16000." } }
variable "node_root_volume_throughput" { type = number default = 125
  validation { condition = var.node_root_volume_throughput >= 125 && var.node_root_volume_throughput <= 1000 error_message = "GP3 throughput must be between 125 and 1000 MiB/s." } }