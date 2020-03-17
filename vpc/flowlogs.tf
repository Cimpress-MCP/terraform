resource "aws_cloudwatch_log_group" "vpc_cloudwatch_group" {
    name = "${var.vpc_name}-vpcflowlogs"
}

resource "aws_flow_log" "vpc_flow_log" {
  log_destination = aws_cloudwatch_log_group.vpc_cloudwatch_group.arn
  iam_role_arn    = aws_iam_role.vpc_flow_role.arn
  vpc_id          = aws_vpc.vpc.id
  traffic_type    = "ALL"
}

resource "aws_iam_role" "vpc_flow_role" {
  name = "${var.vpc_name}-flowrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "vpc_flow_policy" {
  name = "${var.vpc_name}_flow_policy"
  role =aws_iam_role.vpc_flow_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
