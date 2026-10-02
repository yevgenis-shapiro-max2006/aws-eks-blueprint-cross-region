locals {
  endpoint_services = var.enable_vpc_endpoints ? toset([
    "ecr.api",
    "ecr.dkr",
    "logs",
    "sts",
    "ssm",
    "ssmmessages",
    "ec2messages"
  ]) : toset([])
}

resource "aws_vpc_endpoint" "interface" {
  for_each = local.endpoint_services

  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.${each.key}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.cluster_name}-${each.key}"
  }
}

resource "aws_vpc_endpoint" "s3" {
  count = var.enable_vpc_endpoints ? 1 : 0

  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = module.vpc.private_route_table_ids
}
