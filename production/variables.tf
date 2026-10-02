variable "aws_region" {
  description = "AWS Region for the regional EKS cluster."
  type        = string
  default     = "eu-central-1"
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "regional-eks"
}

variable "cluster_version" {
  description = "EKS Kubernetes version."
  type        = string
  default     = "1.33"
}

variable "vpc_cidr" {
  description = "VPC CIDR."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Exactly three AZs used by the regional cluster."
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

  validation {
    condition     = length(var.availability_zones) == 3
    error_message = "Production EKS must use exactly three availability zones."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDRs for the three public subnets."
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs for the three private subnets."
  type        = list(string)
  default     = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
}

variable "cluster_endpoint_public_access" {
  description = "Whether the EKS Kubernetes API is reachable from the public internet."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDRs allowed to reach the public EKS API when public access is enabled."
  type        = list(string)
  default     = []
}

variable "enable_vpc_flow_logs" {
  description = "Enable VPC flow logs to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "enable_vpc_endpoints" {
  description = "Create private VPC endpoints for core AWS services."
  type        = bool
  default     = true
}

variable "system_instance_types" {
  description = "Instance types for the EKS system node group."
  type        = list(string)
  default     = ["m6i.large"]
}

variable "general_instance_types" {
  description = "Instance types for general workloads."
  type        = list(string)
  default     = ["m6i.large", "m6a.large"]
}

variable "system_min_size" {
  type    = number
  default = 3
}

variable "system_desired_size" {
  type    = number
  default = 3
}

variable "system_max_size" {
  type    = number
  default = 6
}

variable "general_min_size" {
  type    = number
  default = 3
}

variable "general_desired_size" {
  type    = number
  default = 3
}

variable "general_max_size" {
  type    = number
  default = 9
}
