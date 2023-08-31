resource "aws_cloudfront_origin_access_identity" "s3" {
  comment = "Used to access the s3 content for the static assets bucket"
}
