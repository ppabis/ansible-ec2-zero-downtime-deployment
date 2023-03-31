resource "aws_iam_role" "app-role" {
  name = "app-role"
  # Most default policy
  assume_role_policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "",
                "Effect": "Allow",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "app-role-policy-target-group" {
  role       = aws_iam_role.app-role.name
  policy_arn = aws_iam_policy.app-target-group-policy.arn
}

resource "aws_iam_policy" "app-target-group-policy" {
  name   = "app-target-group-policy"
  policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": [
                    "elasticloadbalancing:RegisterTargets",
                    "elasticloadbalancing:DeregisterTargets"
                ],
                "Resource": "${aws_alb_target_group.apps.arn}"
            },
            {
                "Sid": "VisualEditor1",
                "Effect": "Allow",
                "Action": [
                    "elasticloadbalancing:DescribeTargetGroups",
                    "elasticloadbalancing:DescribeTargetHealth"
                ],
                "Resource": "*"
            }
        ]
    }
    EOF 
}

resource "aws_iam_instance_profile" "app-role-profile" {
  name = "app-role-profile"
  role = aws_iam_role.app-role.name
}