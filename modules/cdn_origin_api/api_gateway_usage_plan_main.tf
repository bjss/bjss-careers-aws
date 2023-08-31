resource "aws_api_gateway_usage_plan" "main" {
  depends_on = [
    aws_api_gateway_stage.main
  ]

  name        = "${local.prefix}-${var.api_options.api_name}"
  description = "Usage plan for the ${var.api_options.api_name} API stage ${var.identifiers.environment}"

  api_stages {
    api_id = aws_api_gateway_rest_api.main.id
    stage  = aws_api_gateway_stage.main.stage_name
  }

  quota_settings {
    limit  = var.api_options.quota_limit
    offset = 0
    period = "DAY"
  }

  throttle_settings {
    burst_limit = var.api_options.burst_limit
    rate_limit  = var.api_options.rate_limit
  }
}

resource "aws_api_gateway_api_key" "main" {
  count       = var.api_options.api_key_required ? 1 : 0
  name        = "${local.prefix}-${var.api_options.api_name}"
  description = "API Key for the ${var.api_options.api_name} API stage ${var.identifiers.environment}"
  tags        = local.default_tags
  enabled     = true
}

resource "aws_api_gateway_usage_plan_key" "main" {
  count         = var.api_options.api_key_required ? 1 : 0
  key_id        = aws_api_gateway_api_key.main[0].id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.main.id
}
