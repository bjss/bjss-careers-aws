# CDN_ORIGIN_API Terraform Module

This module creates an API Gateway for use as an origin for dynamic content by a CloudFront Distribution. This module creates the API and associated Lambda functions that implement the functionality of each API resource.

The API resources, methods and integrations with Lambda are defined in an OpenApi3.0 specification file that is passed into this module as a parameter.


<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_options"></a> [api\_options](#input\_api\_options) | Settings for this api. Only the API Name, the API Spec and the Lambda Mappings are mandatory | <pre>object({<br>    api_name     = string<br>    openapi_spec = string<br>    lambda_mappings = list(object({<br>      openapi_placeholder = string,<br>      lambda_arn          = string,<br>      lambda_name         = optional(string, "")<br>    }))<br>    api_key_required   = optional(bool, false)<br>    quota_limit        = optional(number, 1000)<br>    rate_limit         = optional(number, 100)<br>    burst_limit        = optional(number, 200)<br>    log_retention_days = optional(number, 30)<br>  })</pre> | n/a | yes |
| <a name="input_identifiers"></a> [identifiers](#input\_identifiers) | Bundle of identifiers useful throughout the application | `map(string)` | n/a | yes |
| <a name="input_module"></a> [module](#input\_module) | The shortname of this module. Can be overridden but a sensible default is provided | `string` | `"webapi"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_invoke_url"></a> [api\_invoke\_url](#output\_api\_invoke\_url) | n/a |
| <a name="output_api_key"></a> [api\_key](#output\_api\_key) | n/a |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.46.0 |
## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_api_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key) | resource |
| [aws_api_gateway_deployment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_method_settings.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings) | resource |
| [aws_api_gateway_rest_api.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_stage.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_api_gateway_usage_plan.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan) | resource |
| [aws_api_gateway_usage_plan_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan_key) | resource |
| [aws_cloudwatch_log_group.api_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.api_gateway_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_lambda_permission.api_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
<!-- END_TF_DOCS -->