module "lambda_update_catalogue" {
  source = "../../modules/lambda"
  module = "updc"

  depends_on = [
    module.cdn_origin_s3,
  ]

  providers = {
    aws               = aws,
    aws.deploy_region = aws
  }

  identifiers = var.identifiers

  lambda_options = {
    function_name        = "update-catalogue"
    function_description = "Adds a new record to the catalogue every time a new image is uploaded"
    handler              = "app.handler"
    source_directory     = "${path.module}/lambda_content/update_catalogue"
    timeout              = 300
    memory_size          = 1024
    extra_env_variables = {
      S3_BUCKET_NAME       = try(module.cdn_origin_s3.bucket_name, "")
      S3_BUCKET_ARN        = try(module.cdn_origin_s3.bucket_arn, "")
      CATALOGUE_TABLE_NAME = var.catalogue_table_name
      CATALOGUE_TABLE_ARN  = var.catalogue_table_arn
      HOST_NAME            = local.cloudfront_fqdn
    }
    extra_policy_attachments = [
      var.catalogue_table_readwrite_policy_arn,
      try(module.cdn_origin_s3.bucket_images_readwrite_policy_arn, ""),
      aws_iam_policy.basic_auth.arn,
    ]
    vpc_id         = var.vpc_id
    vpc_cidr_block = var.vpc_cidr_block
    vpc_subnet_ids = var.vpc_subnet_ids
  }
}
