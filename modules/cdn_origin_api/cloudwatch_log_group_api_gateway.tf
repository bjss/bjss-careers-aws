resource "aws_cloudwatch_log_group" "api_gateway" {
  name = format("%s/%s/%s/api/%s",
    var.identifiers.project,
    var.identifiers.environment,
    var.identifiers.component,
    var.api_options.api_name,
  )
  retention_in_days = var.api_options.log_retention_days
}

resource "aws_cloudwatch_log_group" "api_gateway_execution" {
  name = format("API-Gateway-Execution-Logs_%s/%s",
    aws_api_gateway_rest_api.main.id,
    var.identifiers.environment,
  )
  retention_in_days = var.api_options.log_retention_days
}
