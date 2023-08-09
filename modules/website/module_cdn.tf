module "cdn" {
  source = "../../modules/cdn"

  depends_on = [
    module.cdn_origin_s3,
    module.lambda_basic_auth,
    module.cdn_origin_api,
  ]

  providers = {
    aws           = aws,
    aws.us-east-1 = aws.us-east-1
  }

  module                                    = "cdn"
  identifiers                               = var.identifiers
  cloudfront_origin_access_identity_iam_arn = aws_cloudfront_origin_access_identity.s3.iam_arn
  cloudfront_origin_access_identity_path    = aws_cloudfront_origin_access_identity.s3.cloudfront_access_identity_path
  cloudfront_fqdn                           = local.cloudfront_fqdn
  static_assets_bucket_regional_domain_name = try(module.cdn_origin_s3.bucket_regional_domain_name, "")
  route53_zone_id_environment               = aws_route53_zone.environment.id
  root_object                               = "index.html"
  api_path_patterns                         = ["api"]
  ip_allow_list                             = var.ip_allow_list
  basic_auth_lambda                         = module.lambda_basic_auth.lambda_function_qualified_arn

  cloudfront_max_ttl = 0 #FIXME: temporary while writing html pages

  webapi = {
    api_invoke_url = module.cdn_origin_api.api_invoke_url
    api_key        = module.cdn_origin_api.api_key
  }
}
