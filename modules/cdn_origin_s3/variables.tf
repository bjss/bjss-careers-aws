variable "cloudfront_origin_access_identity_iam_arn" {
  type        = string
  description = "ARN of the CloudFront Origin Access Identity allowed to access this bucket. Created outside of this module to avoid a cyclic dependency"
}

variable "identifiers" {
  type        = map(string)
  description = "Bundle of identifiers useful throughout the application"
}

variable "module" {
  type        = string
  description = "The shortname of this module. Can be overridden but a sensible default is provided"
  default     = "static"
}

variable "static_content_path" {
  type        = string
  description = "File path of the static content. Points to a directory in this repo. All files found here will be copied to the S3 bucket by Terraform"
}
