
output "lambda_function_arn" {
  value = aws_lambda_function.main.arn
}

output "lambda_function_qualified_arn" {
  value = aws_lambda_function.main.qualified_arn
}

output "lambda_function_name" {
  value = aws_lambda_function.main.function_name
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_function.arn
}

output "lambda_log_group_arn" {
  value = aws_cloudwatch_log_group.lambda_function.arn
}

output "lambda_log_group_name" {
  value = aws_cloudwatch_log_group.lambda_function.name
}

