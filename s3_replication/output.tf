output "s3_policy_arn" {
  value = "${aws_iam_policy.s3_policy.arn}"
}

output "s3_bucket" {
  value = "${aws_s3_bucket.s3_bucket.id}"
}

output "s3_bucket_arn" {
  value = "${aws_s3_bucket.s3_bucket.arn}"
}