resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = ""
  description = "Deployment of the api"

  triggers = merge(
    {
      api_name     = var.api_options.api_name
      openapi_spec = sha1(jsonencode(var.api_options.openapi_spec)),
      prefix       = local.prefix,
    },
    {
      for mapping in var.api_options.lambda_mappings :
      mapping.openapi_placeholder => mapping.lambda_arn
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
