variable "identifiers" {
  type        = map(string)
  description = "Bundle of identifiers useful throughout the application"
}

variable "module" {
  type        = string
  description = "The shortname of this module. Can be overridden but provides a sensible default"
  default     = "cat"
}
