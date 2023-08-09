module "lambda_generate_presigned_url" {
  source = "../../modules/lambda"
  module = "psu"

  depends_on = [
    module.cdn_origin_s3,
  ]

  providers = {
    aws               = aws,
    aws.deploy_region = aws
  }

  identifiers = var.identifiers

  lambda_options = {
    function_name        = "generate-presigned-url"
    function_description = "Generates a pre-signed URL for S3 to allow image uploads"
    handler              = "app.handler"
    source_directory     = "${path.module}/lambda_content/generate_presigned_url"
    timeout              = 300
    memory_size          = 1024
    extra_env_variables = {
      S3_BUCKET_NAME = try(module.cdn_origin_s3.bucket_name, "")
      S3_BUCKET_ARN  = try(module.cdn_origin_s3.bucket_arn, "")
    }
    extra_policy_attachments = [
      try(module.cdn_origin_s3.bucket_images_readwrite_policy_arn, "")
    ]
  }
}
