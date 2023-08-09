resource "aws_api_gateway_rest_api" "main" {
  name        = "${local.prefix}-${var.api_options.api_name}"
  description = "Web API for ${var.identifiers.environment}"
  body = templatefile(
    var.api_options.openapi_spec,
    {
      for mapping in var.api_options.lambda_mappings :
      mapping.openapi_placeholder => mapping.lambda_arn
    }
  )

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
