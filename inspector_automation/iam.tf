resource "aws_iam_role" "lambda_role" {
  name                = "lambda-${var.name}-role"
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    actions = [
      "inspector:StartAssessmentRun",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.name}-lambda_policy"
  policy =  "${data.aws_iam_policy_document.lambda_policy_doc.json}"
}


resource "aws_iam_policy_attachment" "lambda_attach" {
  name = "${var.name}-lambda_attach"
  roles = ["${aws_iam_role.lambda_role.name}"]
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}
