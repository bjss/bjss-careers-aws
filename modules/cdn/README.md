# CDN Terraform Module

This Terraform Module creates the Content Delivery Network (CDN) using AWS CloudFront. A suitable SSL Certificate is created for the CloudFront Distribution and a public Route 53 record is added to point at the CloudFront Distribution. A Web Application Firewall is also configured and used for the Distribution.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_path_patterns"></a> [api\_path\_patterns](#input\_api\_path\_patterns) | List of top level web paths in the CloudFront Distribution's API origin. Used to ensure certain paths go to the API (e.g. /api/something) and certain paths go to s3 (e.g. /static/whatever) | `list(string)` | `[]` | no |
| <a name="input_basic_auth_lambda"></a> [basic\_auth\_lambda](#input\_basic\_auth\_lambda) | ARN of the lambda function that performs basic auth validation for Cloudfront | `string` | n/a | yes |
| <a name="input_cloudfront_default_ttl"></a> [cloudfront\_default\_ttl](#input\_cloudfront\_default\_ttl) | The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header | `number` | `0` | no |
| <a name="input_cloudfront_fqdn"></a> [cloudfront\_fqdn](#input\_cloudfront\_fqdn) | Fully qualified domain name to give to the CloudFront Distribution | `string` | n/a | yes |
| <a name="input_cloudfront_max_ttl"></a> [cloudfront\_max\_ttl](#input\_cloudfront\_max\_ttl) | The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated | `number` | `86400` | no |
| <a name="input_cloudfront_min_ttl"></a> [cloudfront\_min\_ttl](#input\_cloudfront\_min\_ttl) | The minimum amount of time (in seconds) that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated | `number` | `0` | no |
| <a name="input_cloudfront_origin_access_identity_iam_arn"></a> [cloudfront\_origin\_access\_identity\_iam\_arn](#input\_cloudfront\_origin\_access\_identity\_iam\_arn) | ARN of the CloudFront Origin Access Identity allowed to access the static assets bucket. This is created outside of the module to avoid a cyclic dependency | `string` | n/a | yes |
| <a name="input_cloudfront_origin_access_identity_path"></a> [cloudfront\_origin\_access\_identity\_path](#input\_cloudfront\_origin\_access\_identity\_path) | Path of the CloudFront Origin Access Identity allowed to access the static assets bucket. This is created outside of the module to avoid a cyclic dependency | `string` | n/a | yes |
| <a name="input_identifiers"></a> [identifiers](#input\_identifiers) | Bundle of identifiers useful throughout the application | `map(string)` | n/a | yes |
| <a name="input_ip_allow_list"></a> [ip\_allow\_list](#input\_ip\_allow\_list) | IP Addresses that are allowed to access this application. The WAF will enforce this allow list | `list(string)` | `[]` | no |
| <a name="input_module"></a> [module](#input\_module) | The shortname of this module. Can be overwritten but provides a sensible default | `string` | `"cdn"` | no |
| <a name="input_root_object"></a> [root\_object](#input\_root\_object) | Default root object for the CloudFront Distribution (e.g. index.html). If not set, then CloudFront will use the first element of var.api\_path\_patterns as a default | `string` | `""` | no |
| <a name="input_route53_zone_id_environment"></a> [route53\_zone\_id\_environment](#input\_route53\_zone\_id\_environment) | ID of the environment's own Route53 Public Hosted Zone, in which to create cloudfront records | `string` | n/a | yes |
| <a name="input_static_assets_bucket_regional_domain_name"></a> [static\_assets\_bucket\_regional\_domain\_name](#input\_static\_assets\_bucket\_regional\_domain\_name) | Regional domain name of the static assets bucket. Used to create a CloudFront Origin based on the static assets bucket | `string` | n/a | yes |
| <a name="input_waf_rate_limit_cdn"></a> [waf\_rate\_limit\_cdn](#input\_waf\_rate\_limit\_cdn) | The rate limit is the maximum number of CDN requests from a single IP address that are allowed in a five-minute period | `number` | `2000` | no |
| <a name="input_webapi"></a> [webapi](#input\_webapi) | Identification details for the CloudFront Distribution's API origin (used for dynamic content) | <pre>object({<br>    api_invoke_url = string<br>    api_key        = string<br>  })</pre> | n/a | yes |
## Outputs

No outputs.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.46.0 |
| <a name="provider_aws.us-east-1"></a> [aws.us-east-1](#provider\_aws.us-east-1) | >=4.46.0 |
## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_route53_record.cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.cdn_alias_A](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.cdn_alias_AAAA](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_wafv2_ip_set.allowlist](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_web_acl.cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
<!-- END_TF_DOCS -->