terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">=4.46.0"
      configuration_aliases = [aws.us-east-1]
    }
  }

  required_version = ">= 1.3.0"
}
