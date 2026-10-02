output "cluster_name" { value = module.eks.cluster_name }
output "cluster_endpoint" { value = module.eks.cluster_endpoint }
output "vpc_id" { value = module.vpc.vpc_id }
output "private_subnet_ids" { value = module.vpc.private_subnets }
output "public_subnet_ids" { value = module.vpc.public_subnets }
output "nat_gateway_ids" { value = module.vpc.natgw_ids }
output "eks_kms_key_arn" { value = aws_kms_key.eks.arn }