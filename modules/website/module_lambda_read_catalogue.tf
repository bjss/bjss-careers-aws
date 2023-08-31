module "lambda_read_catalogue" {
  source = "../../modules/lambda"
  module = "rdc"

  providers = {
    aws               = aws,
    aws.deploy_region = aws
  }

  identifiers = var.identifiers

  lambda_options = {
    function_name        = "read-catalogue"
    function_description = "Reads all records from the catalogue"
    handler              = "app.handler"
    source_directory     = "${path.module}/lambda_content/read_catalogue"
    timeout              = 300
    memory_size          = 1024
    extra_env_variables = {
      CATALOGUE_TABLE_NAME = var.catalogue_table_name
      CATALOGUE_TABLE_ARN  = var.catalogue_table_arn
    }
    extra_policy_attachments = [
      var.catalogue_table_readwrite_policy_arn,
    ]
  }
}
