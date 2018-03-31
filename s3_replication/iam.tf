########## ROLES ###########
#
#
resource "aws_iam_role" "replica_role" {
  name               = "${var.main_bucket_name}-replication_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

########## POLICY DOCS ############
#
#
data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    actions = [
      "s3:*"
    ]
    effect = "Allow"
        
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*",
      "${aws_s3_bucket.s3_bucket.arn}",
      "${aws_s3_bucket.s3_repl_bucket.arn}/*",
      "${aws_s3_bucket.s3_repl_bucket.arn}"
    ]
  }
}

data "aws_iam_policy_document" "replica_access_policy" {
  statement {
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket"
    ]
    effect = "Allow"
        
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}"
    ]
  }

  statement {
    actions = [
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging"
    ]
    effect = "Allow"
        
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete"
    ]
    effect = "Allow"

    resources = [
      "${aws_s3_bucket.s3_repl_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_policy" {
  name = "${var.main_bucket_name}-policy"
  policy =  "${data.aws_iam_policy_document.s3_access_policy.json}"
}

resource "aws_iam_policy" "replica_policy" {
  name = "${var.main_bucket_name}-replication_policy"
  policy = "${data.aws_iam_policy_document.replica_access_policy.json}"
}


resource "aws_iam_policy_attachment" "replica_attach" {
  name = "${var.main_bucket_name}-repl_policy_attachment"
  roles = ["${aws_iam_role.replica_role.name}"]
  policy_arn = "${aws_iam_policy.replica_policy.arn}"
}

resource "aws_iam_policy_attachment" "s3_attach" {
  name = "${var.main_bucket_name}-policy_attachment"
  roles = ["${var.access_roles_name}"]
  policy_arn = "${aws_iam_policy.s3_policy.arn}"
}
