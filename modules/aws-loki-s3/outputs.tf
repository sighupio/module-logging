output "loki_iam_role_arn" {
  value = aws_iam_role.loki.arn
}

output "loki_s3_bucket_name" {
  value = aws_s3_bucket.loki.id
}

output "loki_s3_bucket_arn" {
  value = aws_s3_bucket.loki.arn
}
