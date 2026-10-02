# Production 3-AZ Regional EKS Blueprint

This directory is an isolated production infrastructure layer for one Amazon EKS cluster spanning three Availability Zones in a single AWS Region.

## Architecture

- 1 VPC across exactly 3 AZs
- 3 public subnets and 3 private subnets
- 1 NAT Gateway per AZ
- EKS control-plane networking in private subnets
- Private Kubernetes API endpoint by default
- Optional public API access restricted by explicit CIDRs
- EKS managed node groups for system and general workloads
- EKS Pod Identity agent and Amazon EBS CSI add-ons
- Kubernetes secrets encrypted with a dedicated customer-managed KMS key
- EKS control-plane logs enabled
- VPC Flow Logs enabled by default
- Private ECR, STS, SSM, CloudWatch Logs and S3 endpoints
- No SSH access is required for worker nodes

The blueprint uses the Terraform AWS EKS module 21.x and VPC module 6.7.x. Current module documentation confirms the 21.x EKS interface uses `enabled_log_types` and `encryption_config`, and supports private API endpoints and EKS access entries. urlEKS module documentationhttps://github.com/terraform-aws-modules/terraform-aws-eks

## State

The S3 backend is intentionally empty in Terraform code. Configure state at deployment time so credentials, account-specific bucket names and lock configuration are not committed.

Example:

```bash
terraform init \
  -backend-config="bucket=<state-bucket>" \
  -backend-config="key=eks/production/terraform.tfstate" \
  -backend-config="region=eu-central-1" \
  -backend-config="use_lockfile=true"
```

Use an encrypted, versioned S3 bucket with restricted IAM access.

## Deployment

```bash
cd production
terraform init -backend-config=...
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

For a private-only Kubernetes API endpoint, the Terraform runner and subsequent `kubectl` clients need network reachability to the VPC, such as a runner inside the VPC or an approved VPN/private connectivity path.

## Cluster administration

Set `cluster_admin_principal_arns` to the IAM role ARNs that should receive the EKS cluster administrator access policy. Cluster creator administrator access is deliberately disabled so administrative access is explicit and reviewable.

## Storage

The standard EBS CSI add-on is enabled. After the cluster is reachable, apply `kubernetes/gp3-storage-class.yaml` if GP3 should be the default StorageClass for workloads. AWS EKS best practices recommend GP3 for general-purpose block storage. urlAWS EKS storage best practiceshttps://docs.aws.amazon.com/eks/latest/best-practices/cost-opt-storage.html

## Validation

Run at minimum:

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
terraform plan -var-file=terraform.tfvars
```

A plan against the real target AWS account is required before production apply because AZ availability, service quotas, IAM permissions and the selected Kubernetes platform version are account/region dependent.
