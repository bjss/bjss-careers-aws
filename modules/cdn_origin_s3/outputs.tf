output "bucket_name" {
  value = aws_s3_bucket.static_assets.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.static_assets.arn
}

output "bucket_id" {
  value = aws_s3_bucket.static_assets.id
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.static_assets.bucket_regional_domain_name
}

output "bucket_images_readwrite_policy_arn" {
  value = aws_iam_policy.bucket_images_readwrite.arn
}
