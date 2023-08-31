module "cdn_origin_api" {
  source = "../../modules/cdn_origin_api"
  module = "webapi"

  depends_on = [
    module.lambda_generate_presigned_url,
    module.lambda_read_catalogue,
  ]

  identifiers = var.identifiers

  api_options = {
    api_name         = "dynamic"
    openapi_spec     = "${path.module}/openapi_specs/openapi3_website.json"
    api_key_required = true

    lambda_mappings = [
      {
        openapi_placeholder = "TFSUB_PSU_LAMBDA_ARN"
        lambda_arn          = try(module.lambda_generate_presigned_url.lambda_function_arn, "")
        lambda_name         = try(module.lambda_generate_presigned_url.lambda_function_name, "")
      },
      {
        openapi_placeholder = "TFSUB_DBSCAN_LAMBDA_ARN"
        lambda_arn          = try(module.lambda_read_catalogue.lambda_function_arn, "")
        lambda_name         = try(module.lambda_read_catalogue.lambda_function_name, "")
      },
    ]
  }
}
