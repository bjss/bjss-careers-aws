#@filename_check_ignore - file contains multiple DNS records of equal importance so plural filename is ok
resource "aws_route53_record" "cdn_alias_A" {
  name    = var.cloudfront_fqdn
  zone_id = var.route53_zone_id_environment
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cdn_alias_AAAA" {
  name    = var.cloudfront_fqdn
  zone_id = var.route53_zone_id_environment
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
