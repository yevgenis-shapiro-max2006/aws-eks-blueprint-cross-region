data "aws_caller_identity" "current" {}
resource "aws_kms_key" "eks" {
  description = format("KMS key for EKS secrets in %s", var.aws_region)
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid = "EnableAccountAdministration"
      Effect = "Allow"
      Principal = { AWS = format("arn:aws:iam::%s:root", data.aws_caller_identity.current.account_id) }
      Action = "kms:*"
      Resource = "*"
    }]
  })
}
resource "aws_kms_alias" "eks" {
  name = format("alias/%s-eks", var.cluster_name)
  target_key_id = aws_kms_key.eks.key_id
}