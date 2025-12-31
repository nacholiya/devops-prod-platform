resource "aws_iam_policy" "devops_readonly" {
  name        = "devops-readonly-policy"
  description = "Least privilege policy for DevOps operations"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::devops-prod-platform-tfstate-nikhil",
          "arn:aws:s3:::devops-prod-platform-tfstate-nikhil/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:DescribeSecurityGroups"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "devops_role" {
  name = "devops-prod-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "devops_policy_attach" {
  role       = aws_iam_role.devops_role.name
  policy_arn = aws_iam_policy.devops_readonly.arn
}

