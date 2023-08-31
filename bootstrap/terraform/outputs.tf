output "state_bucket_arn" {
  value = aws_s3_bucket.state.arn
}

output "state_bucket_name" {
  value = aws_s3_bucket.state.bucket
}

output "state_bucket_key" {
  value = aws_kms_key.state.arn
}

output "state_lock_table_arn" {
  value = aws_dynamodb_table.terraform_statelock.arn
}
