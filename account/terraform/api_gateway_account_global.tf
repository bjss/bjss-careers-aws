resource "aws_api_gateway_account" "global" {
  cloudwatch_role_arn = aws_iam_role.apigateway_logging.arn
}
