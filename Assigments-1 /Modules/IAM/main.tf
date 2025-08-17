
data "aws_iam_policy_document" "ec2_s3_policy" {
  statement {
    effect = "Allow"
    actions = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }

   statement {
    effect = "Allow"
    actions = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]
  }
}

resource "aws_iam_policy" "ec2_s3_policy" {
  name   = "EC2S3ListAndPutPolicy"
  policy = data.aws_iam_policy_document.ec2_s3_policy.json
}

resource "aws_iam_role" "ec2_role" {
  name = "EC2S3AccessRole"

  assume_role_policy = jsonencode({
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action   = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "infosystestprofile"
  role = aws_iam_role.ec2_role.name
}



