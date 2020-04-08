resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl = "private"

  force_destroy = var.force_destroy

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id = "rotate"
    enabled = true
    prefix = ""

    transition {
      days = var.transition_days
      storage_class = var.transition_storage_class
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${lookup(var.region_identifier, data.aws_region.current.name)}:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    }]
  }
  POLICY
  
  tags = merge(map("Name", var.bucket_name), var.extra_tags
}
