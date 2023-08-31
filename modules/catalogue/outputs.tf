output "catalogue_table_name" {
  value = aws_dynamodb_table.catalogue.name
}

output "catalogue_table_arn" {
  value = aws_dynamodb_table.catalogue.arn
}

output "catalogue_table_readwrite_policy_arn" {
  value = aws_iam_policy.catalogue_table_readwrite.arn
}
