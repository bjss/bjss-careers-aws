variable "api_options" {
  type = object({
    api_name     = string
    openapi_spec = string
    lambda_mappings = list(object({
      openapi_placeholder = string,
      lambda_arn          = string,
      lambda_name         = optional(string, "")
    }))
    api_key_required   = optional(bool, false)
    quota_limit        = optional(number, 1000)
    rate_limit         = optional(number, 100)
    burst_limit        = optional(number, 200)
    log_retention_days = optional(number, 30)
  })
  description = "Settings for this api. Only the API Name, the API Spec and the Lambda Mappings are mandatory"
}

variable "identifiers" {
  type        = map(string)
  description = "Bundle of identifiers useful throughout the application"
}

variable "module" {
  type        = string
  description = "The shortname of this module. Can be overridden but a sensible default is provided"
  default     = "webapi"
}
