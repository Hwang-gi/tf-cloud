resource "aws_iam_role" "eks_user_role" {
  name = "${var.user_name}-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:user/${var.user_name}"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}
