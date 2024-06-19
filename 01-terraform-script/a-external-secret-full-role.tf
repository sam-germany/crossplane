

resource "aws_iam_role" "my-secret-role" {
  name = "my-secret-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::553401569158:oidc-provider/oidc.eks.eu-west-1.amazonaws.com/id/998CEB5E3D8DE91D820C6C15C5EEFA59"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "oidc.eks.eu-west-1.amazonaws.com/id/998CEB5E3D8DE91D820C6C15C5EEFA59:sub": "system:serviceaccount:test-ns:test-sa"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "my_secret_policy" {
  name        = "my-secret-policy"
  description = "Policy for accessing Secrets Manager and Parameter Store"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowAccessToSecretsManager",
        "Effect": "Allow",
        "Action": [
          "secretsmanager:ListSecrets",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Resource": [
          "arn:aws:secretsmanager:eu-west-1:553401569158:secret:*"
        ]
      },
      {
        "Sid": "AllowAccessToParameterStore",
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
        ],
        "Resource": [
          "arn:aws:ssm:eu-west-1:553401569158:parameter/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.my-secret-role.name
  policy_arn = aws_iam_policy.my_secret_policy.arn
}
