variable "api_path_patterns" {
  type        = list(string)
  description = "List of top level web paths in the CloudFront Distribution's API origin. Used to ensure certain paths go to the API (e.g. /api/something) and certain paths go to s3 (e.g. /static/whatever)"
  default     = []
}

variable "basic_auth_lambda" {
  type        = string
  description = "ARN of the lambda function that performs basic auth validation for Cloudfront"
}

variable "cloudfront_default_ttl" {
  type        = number
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header"
  default     = 0
}

variable "cloudfront_max_ttl" {
  type        = number
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated"
  default     = 86400 # 1 day
}

variable "cloudfront_min_ttl" {
  type        = number
  description = "The minimum amount of time (in seconds) that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated"
  default     = 0
}

variable "cloudfront_fqdn" {
  type        = string
  description = "Fully qualified domain name to give to the CloudFront Distribution"
}

variable "cloudfront_origin_access_identity_iam_arn" {
  type        = string
  description = "ARN of the CloudFront Origin Access Identity allowed to access the static assets bucket. This is created outside of the module to avoid a cyclic dependency"
}

variable "cloudfront_origin_access_identity_path" {
  type        = string
  description = "Path of the CloudFront Origin Access Identity allowed to access the static assets bucket. This is created outside of the module to avoid a cyclic dependency"
}

variable "identifiers" {
  type        = map(string)
  description = "Bundle of identifiers useful throughout the application"
}

variable "ip_allow_list" {
  type        = list(string)
  description = "IP Addresses that are allowed to access this application. The WAF will enforce this allow list"
  default     = []
}

variable "module" {
  type        = string
  description = "The shortname of this module. Can be overwritten but provides a sensible default"
  default     = "cdn"
}

variable "root_object" {
  type        = string
  description = "Default root object for the CloudFront Distribution (e.g. index.html). If not set, then CloudFront will use the first element of var.api_path_patterns as a default"
  default     = ""
}

variable "route53_zone_id_environment" {
  type        = string
  description = "ID of the environment's own Route53 Public Hosted Zone, in which to create cloudfront records"
}

variable "static_assets_bucket_regional_domain_name" {
  type        = string
  description = "Regional domain name of the static assets bucket. Used to create a CloudFront Origin based on the static assets bucket"
}

variable "waf_rate_limit_cdn" {
  type        = number
  description = "The rate limit is the maximum number of CDN requests from a single IP address that are allowed in a five-minute period"
  default     = 2000
}

variable "webapi" {
  type = object({
    api_invoke_url = string
    api_key        = string
  })
  description = "Identification details for the CloudFront Distribution's API origin (used for dynamic content)"
}
