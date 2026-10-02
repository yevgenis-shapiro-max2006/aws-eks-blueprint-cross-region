# Multi-Region Production EKS Blueprint

Creates two independent EKS clusters in eu-west-1 and eu-west-2.

Each Region has three AZs, three public/private subnets, one NAT Gateway per AZ, private EKS API access by default, managed system/general node groups, 100 GiB encrypted GP3 root volumes, EBS CSI, Pod Identity, KMS secrets encryption, control-plane logs, VPC Flow Logs, and private AWS service endpoints.

VPC CIDRs:
- eu-west-1: 10.10.0.0/16
- eu-west-2: 10.20.0.0/16

No Transit Gateway, VPC peering, AWS Cloud WAN, inter-Region routing, or other cross-Region network connectivity is created.

Deploy:
```bash
cd production-multi-region
terraform init -backend-config=...
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Both clusters are managed by this Terraform root/state. DNS failover, data replication, application failover, and application-level cross-Region connectivity are intentionally outside this stack.