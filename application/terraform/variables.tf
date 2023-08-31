variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID into which we are deploying"
  default     = "322411843910"
}

variable "component" {
  type        = string
  description = "Name of the terraform configuration. Ordinarily set via the default value. This will be used to name resources"
  default     = "app"
}

variable "ip_allow_list" {
  type        = list(string)
  description = "IP Addresses that are allowed to access this application. Any empty list means no allowlist is applied"
  default     = []
}

variable "module" {
  type        = string
  description = "Name of the local terraform module. This will be used to name resources. Initialised to n/a outside of any modules"
  default     = "n/a"
}

variable "project" {
  type        = string
  description = "The name of the Project. This will be used to name resources created by this Terraform configuration"
  default     = "techtest"
}

variable "region" {
  type        = string
  description = "The AWS Region into which we are deploying"
  default     = "eu-west-2"
}


