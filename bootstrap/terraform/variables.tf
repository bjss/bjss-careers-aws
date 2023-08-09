variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID into which we are bootstrapping the project"
  default     = "322411843910"
}

variable "component" {
  type        = string
  description = "Name of the terraform configuration. Ordinarily set via the default value"
  default     = "bootstrap"
}

variable "module" {
  type        = string
  description = "Name of the local terraform module. Initialised to n/a outside of any modules"
  default     = "n/a"
}

variable "project" {
  type        = string
  description = "The name of the Project we are bootstrapping. This will be used in the state bucket and lock table names"
  default     = "techtest"
}

variable "region" {
  type        = string
  description = "The AWS Region into which we are bootstrapping the project"
  default     = "eu-west-2"
}
