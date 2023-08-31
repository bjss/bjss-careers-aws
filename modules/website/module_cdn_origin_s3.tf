module "cdn_origin_s3" {
  source                                    = "../../modules/cdn_origin_s3"
  module                                    = "static"
  identifiers                               = var.identifiers
  static_content_path                       = "${path.module}/static_pages"
  cloudfront_origin_access_identity_iam_arn = aws_cloudfront_origin_access_identity.s3.iam_arn
}
