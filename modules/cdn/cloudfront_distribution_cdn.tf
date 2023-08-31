resource "aws_cloudfront_distribution" "cdn" {
  depends_on = [
    aws_acm_certificate_validation.cdn
  ]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Tech Test CDN (${var.identifiers.environment})"
  default_root_object = length(var.root_object) > 0 ? var.root_object : var.api_path_patterns[0]
  price_class         = "PriceClass_100"
  web_acl_id          = aws_wafv2_web_acl.cdn.arn

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["GB"]
    }
  }

  aliases = [
    var.cloudfront_fqdn,
  ]

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cdn.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  # Static Assets bucket S3 origin
  origin {
    domain_name = var.static_assets_bucket_regional_domain_name
    origin_id   = "${local.prefix}-origin-static"
    s3_origin_config {
      origin_access_identity = var.cloudfront_origin_access_identity_path
    }
  }

  # API Gateway origin
  origin {
    domain_name = replace(var.webapi.api_invoke_url, "/^https?://([^/]*).*/", "$1")
    origin_id   = "${local.prefix}-origin-api"
    origin_path = "/${var.identifiers.environment}"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
    custom_header {
      name  = "x-api-key"
      value = var.webapi.api_key
    }
  }

  # Static assets S3 content
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.prefix}-origin-static"

    forwarded_values {
      query_string = false
      headers      = ["Origin", "authorization"]
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.cloudfront_min_ttl
    default_ttl            = var.cloudfront_default_ttl
    max_ttl                = var.cloudfront_max_ttl
    compress               = true

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = var.basic_auth_lambda
      include_body = false
    }
  }

  # API Gateway content
  dynamic "ordered_cache_behavior" {
    for_each = toset(var.api_path_patterns)
    content {
      path_pattern     = "/${ordered_cache_behavior.value}*"
      allowed_methods  = ["GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "DELETE"]
      cached_methods   = ["GET", "HEAD"]
      target_origin_id = "${local.prefix}-origin-api"

      forwarded_values {
        query_string = true
        headers      = ["Origin", "authorization"]
        cookies {
          forward = "all"
        }
      }

      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = var.cloudfront_min_ttl
      default_ttl            = var.cloudfront_default_ttl
      max_ttl                = var.cloudfront_max_ttl
      compress               = true

      lambda_function_association {
        event_type   = "viewer-request"
        lambda_arn   = var.basic_auth_lambda
        include_body = false
      }
    }
  }
}

