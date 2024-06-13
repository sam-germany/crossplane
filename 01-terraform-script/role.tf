resource "aws_iam_role" "crossplane-role" {
  name = "crossplane-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "crossplane-policy" {
  name        = "crossplane-policy"
  description = "Policy with AdministratorAccess, AmazonS3FullAccess, and AmazonVPCFullAccess"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "s3:*"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "ec2:*",
          "vpc:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example_attach_1" {
  role       = aws_iam_role.crossplane-role.name
  policy_arn = aws_iam_policy.crossplane-policy.arn
}

resource "aws_iam_role_policy_attachment" "example_attach_2" {
  role       = aws_iam_role.crossplane-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "example_attach_3" {
  role       = aws_iam_role.crossplane-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "example_attach_4" {
  role       = aws_iam_role.crossplane-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}