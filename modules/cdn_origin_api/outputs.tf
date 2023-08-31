
output "api_invoke_url" {
  value = "${aws_api_gateway_rest_api.main.id}.execute-api.${var.identifiers.region}.amazonaws.com"
}

output "api_key" {
  value = try(aws_api_gateway_api_key.main[0].value, "no_key")
}
