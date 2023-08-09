resource "aws_cloudwatch_log_group" "lambda_function" {
  name              = "/aws/lambda/${local.prefix}-${var.lambda_options.function_name}"
  retention_in_days = var.lambda_options.log_retention
}
