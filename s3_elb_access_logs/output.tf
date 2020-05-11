output "bucket_name" {
  value = aws_s3_bucket.s3_bucket.id
}

output "bucket_arn" {
    value = aws_s3_bucket.s3_bucket.arn
}
