
resource "aws_iam_role" "my_secret_cluster_role" {
  name = "my-secret-cluster-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::553401569158:oidc-provider/oidc.eks.eu-west-1.amazonaws.com/id/998CEB5E3D8DE91D820C6C15C5EEFA59"
        },
        "Action": "sts:AssumeRoleWithWebIdentity"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_policy_b" {
  role       = aws_iam_role.my_secret_cluster_role.name
  policy_arn = aws_iam_policy.my_secret_policy.arn
}
