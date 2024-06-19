/* 
# Define the IAM policy to access Secrets Manager
resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "SecretsManagerAccessPolicy"
  description = "Policy to allow access to AWS Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ],
        Resource = "*"
      }
    ]
  })
}

# Define the IAM role for ExternalSecrets
resource "aws_iam_role" "external_secrets_role" {
  name = "ExternalSecretsRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::553401569158:oidc-provider/https://oidc.eks.eu-west-1.amazonaws.com/id/B086D456CE22905C8450353EBD7A8BCF"
        },
        Action = "sts:AssumeRoleWithWebIdentity"
      }
    ]
  })
} 

# Attach the policy to the ExternalSecrets role
resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
  role       = aws_iam_role.external_secrets_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}
*/
# Create a policy to allow EKS worker nodes to assume the ExternalSecretsRole
resource "aws_iam_policy" "allow_assume_role_policy" {
  name        = "AllowAssumeExternalSecretsRole"
  description = "Policy to allow EKS worker nodes to assume ExternalSecretsRole"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "arn:aws:iam::553401569158:role/ExternalSecretsRole"
      }
    ]
  })
}


# Attach the policy to the EKS worker node role
resource "aws_iam_role_policy_attachment" "attach_assume_role_policy" {
  policy_arn = aws_iam_policy.allow_assume_role_policy.arn
  role       = aws_iam_role.worker.name  
  
}
