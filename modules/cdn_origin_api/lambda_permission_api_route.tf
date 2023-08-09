
resource "aws_lambda_permission" "api_route" {
  for_each = toset([
    for mapping in var.api_options.lambda_mappings :
    mapping.lambda_name
  ])

  statement_id  = "AllowAPIInvoke${each.value}"
  action        = "lambda:InvokeFunction"
  function_name = each.value
  principal     = "apigateway.amazonaws.com"
  source_arn    = format("${aws_api_gateway_rest_api.main.execution_arn}/${var.identifiers.environment}/*")
}
