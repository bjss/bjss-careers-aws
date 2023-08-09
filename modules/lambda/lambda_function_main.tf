resource "aws_lambda_function" "main" {
  function_name    = "${local.prefix}-${var.lambda_options.function_name}"
  description      = var.lambda_options.function_description
  filename         = data.archive_file.source_zip.output_path
  source_code_hash = data.archive_file.source_zip.output_base64sha256
  tags             = local.default_tags
  provider         = aws.deploy_region

  role        = aws_iam_role.lambda_function.arn
  handler     = var.lambda_options.handler
  runtime     = var.lambda_options.runtime
  timeout     = var.lambda_options.timeout
  memory_size = var.lambda_options.memory_size
  publish     = var.lambda_options.is_edge_lambda ? true : false

  dynamic "environment" {
    for_each = var.lambda_options.is_edge_lambda ? [] : [1]
    content {
      variables = merge(
        {
          "ENVIRONMENT" = var.identifiers.environment
          "REGION"      = var.identifiers.region
          "LOG_LEVEL"   = var.lambda_options.log_level
        },
        var.lambda_options.extra_env_variables
      )
    }
  }

  dynamic "vpc_config" {
    for_each = length(var.lambda_options.vpc_id) > 0 ? [1] : []
    content {
      subnet_ids         = var.lambda_options.vpc_subnet_ids
      security_group_ids = [aws_security_group.vpc_lambda[0].id]
    }
  }
}
