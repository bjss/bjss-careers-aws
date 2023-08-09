resource "aws_wafv2_ip_set" "allowlist" {
  provider           = aws.us-east-1
  name               = "${local.prefix}-allowlist"
  description        = "IP addresses allowed to access this environment"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses = flatten([
    var.ip_allow_list,
  ])
}
