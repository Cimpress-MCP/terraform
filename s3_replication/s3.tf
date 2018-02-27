# this is the main (source) bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.main_bucket_name}"
  acl = "private"

  force_destroy = true

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${aws_s3_bucket.log_bucket.id}"
  }

  lifecycle_rule {
    id = "rotate"
    enabled = true
    prefix = ""

    transition {
      days = "${var.transition_days}"
      storage_class = "${var.transition_storage_class}"
    }
  }

  replication_configuration {
    role = "${aws_iam_role.replica_role.arn}"
    rules {
      id = "repl_rule"
      prefix = ""
      status = "Enabled"

      destination {
        bucket        = "${aws_s3_bucket.s3_repl_bucket.arn}"
        storage_class = "${var.replica_storage_class}"
      }
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags {
    Name = "${var.tag_name}"
    Project = "${var.tag_project}"
    Squad = "${var.tag_squad}"
  }
}

resource "aws_s3_bucket" "s3_repl_bucket" {
  provider = "aws.repl"
  bucket   = "${var.replication_bucket_name}"

  force_destroy = true

  lifecycle_rule {
    id = "rotate"
    enabled = true
    prefix = ""

    transition {
      days = "${var.transition_days}"
      storage_class = "${var.transition_storage_class}"
    }
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags {
    Name = "${var.tag_name}-repl"
    Project = "${var.tag_project}"
    Squad = "${var.tag_squad}"
  }
}

# logging of the source bucket
resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.main_bucket_name}-logs"
  acl    = "log-delivery-write"

  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags {
    Name = "${var.tag_name}-logs"
    Project = "${var.tag_project}"
    Squad = "${var.tag_squad}"
  }
}