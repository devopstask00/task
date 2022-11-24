resource "aws_iam_user" "terraformuser" {
  name = "terraformuser"

}

resource "aws_iam_access_key" "terraform-ak" {
  user = aws_iam_user.terraformuser.name
}

resource "aws_iam_user_policy" "tf-po" {
  name = "tf-po"
  user = aws_iam_user.terraformuser.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAllPermissions",
            "Effect": "Allow",
            "NotAction": [
                "lightsail:*",
                "sagemaker:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


resource "aws_iam_role" "aws-eks-hadi-prod" {
  name = "aws-eks-hadi-prod"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role" "aws-eks-hadi-dev" {
  name = "aws-eks-hadi-dev"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "allow-to-user" {
  name        = "allow-to-user"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAllPermissions",
            "Effect": "Allow",
            "NotAction": [
                "lightsail:*",
                "sagemaker:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "role-user-policy-attach" {
  name       = "role-user-policy-attach"
  users      = [aws_iam_user.terraformuser.name]
  roles      = [aws_iam_role.aws-eks-hadi-prod.name, aws_iam_role.aws-eks-hadi-dev.name]
  policy_arn = aws_iam_policy.allow-to-user.arn
}
