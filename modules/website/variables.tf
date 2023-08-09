variable "catalogue_table_arn" {
  type        = string
  description = "ARN of the DynamoDB catalogue table to update each time an image is written to S3"
}

variable "catalogue_table_name" {
  type        = string
  description = "Name of the DynamoDB catalogue table to update each time an image is written to S3"
}

variable "catalogue_table_readwrite_policy_arn" {
  type        = string
  description = "ARN of the IAM Policy that allows the DynamoDB catalogue table to be updated"
}

variable "identifiers" {
  type        = map(string)
  description = "Bundle of identifiers useful throughout the application"
}

variable "ip_allow_list" {
  type        = list(string)
  description = "IP Addresses that are allowed to access this application"
  default     = []
}

variable "module" {
  type        = string
  description = "The shortname of this module"
  default     = "web"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block of the VPC to use for any VPC-attached lambdas"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to use for any VPC-attached lambdas"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "Subnet IDs of the VPC to use for any VPC-attached lambdas"
}
