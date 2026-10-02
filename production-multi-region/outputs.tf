output "eu_west_1" {
  value = {
    cluster_name = module.eks_eu_west_1.cluster_name
    cluster_endpoint = module.eks_eu_west_1.cluster_endpoint
    vpc_id = module.eks_eu_west_1.vpc_id
    private_subnet_ids = module.eks_eu_west_1.private_subnet_ids
    public_subnet_ids = module.eks_eu_west_1.public_subnet_ids
    nat_gateway_ids = module.eks_eu_west_1.nat_gateway_ids
    eks_kms_key_arn = module.eks_eu_west_1.eks_kms_key_arn
  }
}
output "eu_west_2" {
  value = {
    cluster_name = module.eks_eu_west_2.cluster_name
    cluster_endpoint = module.eks_eu_west_2.cluster_endpoint
    vpc_id = module.eks_eu_west_2.vpc_id
    private_subnet_ids = module.eks_eu_west_2.private_subnet_ids
    public_subnet_ids = module.eks_eu_west_2.public_subnet_ids
    nat_gateway_ids = module.eks_eu_west_2.nat_gateway_ids
    eks_kms_key_arn = module.eks_eu_west_2.eks_kms_key_arn
  }
}