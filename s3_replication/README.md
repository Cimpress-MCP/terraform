# S3 Replication
This terraform module allows you to create an S3 bucket with geo replication and logs enabled.

It also enforces encryption at rest using SSE-AES.

At least one IAM role is required, in order to allow it to access the S3 buckets.

# Example

```
resource "aws_iam_role" "access_role" {
  name                = "access-s3-role"
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
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

module "s3_repl" {
  source = "/path/to/module/s3_replication"
  
  main_bucket_name = "my-new-bucket"

  replication_bucket_name = "my-new-bucket-repl"

  replica_region = "us-west-1"

  tag_name = "my-new-bucket"

  tag_project = "my-super-project"
  tag_squad = "SET"

  access_roles_name = ["${aws_iam_role.access_role.name}"]
}
```