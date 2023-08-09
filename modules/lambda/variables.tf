variable "identifiers" {
  type        = map(string)
  description = "Bundle of identifiers useful throughout the application"
}

variable "lambda_options" {
  type = object({
    function_name            = string
    function_description     = string
    handler                  = string
    source_directory         = string
    runtime                  = optional(string, "nodejs18.x")
    log_level                = optional(string, "info")
    log_retention            = optional(number, 30)
    timeout                  = optional(number, 300)
    memory_size              = optional(number, 1024)
    extra_env_variables      = optional(map(string), {})
    extra_policy_attachments = optional(list(string), [])
    vpc_id                   = optional(string, "")
    vpc_cidr_block           = optional(string, "")
    vpc_subnet_ids           = optional(list(string), [])
    is_edge_lambda           = optional(bool, false)
  })
  description = "Settings for this lambda"
}

variable "module" {
  type        = string
  description = "The shortname of this module"
  default     = "lda"
}
