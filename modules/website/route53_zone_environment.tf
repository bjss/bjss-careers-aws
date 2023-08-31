# Lookup existing parend DNS domain
data "aws_route53_zone" "bjsscareers" {
  name         = "bjsscareers.co.uk"
  private_zone = false
}

# Create a public DNS zone for this environment
resource "aws_route53_zone" "environment" {
  name    = local.cloudfront_fqdn
  comment = "${var.identifiers.environment} web public zone"
}

# Add record to bjsscareers to route to the environment zone
resource "aws_route53_record" "environment" {
  name    = aws_route53_zone.environment.name
  zone_id = data.aws_route53_zone.bjsscareers.zone_id
  type    = "NS"
  records = aws_route53_zone.environment.name_servers
  ttl     = 600
}
