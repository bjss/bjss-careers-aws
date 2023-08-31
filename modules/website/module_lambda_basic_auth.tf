module "lambda_basic_auth" {
  source = "../../modules/lambda"
  module = "auth"

  providers = {
    aws               = aws,
    aws.deploy_region = aws.us-east-1
  }

  identifiers = var.identifiers

  lambda_options = {
    function_name        = "basic-auth"
    function_description = "Lambda Edge function to perform basic username and password checking"
    handler              = "app.handler"
    source_directory     = "${path.module}/lambda_content/basic_auth"
    timeout              = 5
    memory_size          = 128
    extra_env_variables  = {}
    is_edge_lambda       = true

    extra_policy_attachments = [
      aws_iam_policy.basic_auth.arn
    ]
  }
}
