# Lambda Terraform Module

This Module creates a Lambda function based on the input parameters. Only the Lambda Name, Description, Handler and Source Directory are mandatory parameters.

The module takes care of creating Log Groups, IAM Roles, and Security Groups for the Lambda, all based on the input parameters.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identifiers"></a> [identifiers](#input\_identifiers) | Bundle of identifiers useful throughout the application | `map(string)` | n/a | yes |
| <a name="input_lambda_options"></a> [lambda\_options](#input\_lambda\_options) | Settings for this lambda | <pre>object({<br>    function_name            = string<br>    function_description     = string<br>    handler                  = string<br>    source_directory         = string<br>    runtime                  = optional(string, "nodejs18.x")<br>    log_level                = optional(string, "info")<br>    log_retention            = optional(number, 30)<br>    timeout                  = optional(number, 300)<br>    memory_size              = optional(number, 1024)<br>    extra_env_variables      = optional(map(string), {})<br>    extra_policy_attachments = optional(list(string), [])<br>    vpc_id                   = optional(string, "")<br>    vpc_cidr_block           = optional(string, "")<br>    vpc_subnet_ids           = optional(list(string), [])<br>    is_edge_lambda           = optional(bool, false)<br>  })</pre> | n/a | yes |
| <a name="input_module"></a> [module](#input\_module) | The shortname of this module | `string` | `"lda"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | n/a |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | n/a |
| <a name="output_lambda_function_qualified_arn"></a> [lambda\_function\_qualified\_arn](#output\_lambda\_function\_qualified\_arn) | n/a |
| <a name="output_lambda_log_group_arn"></a> [lambda\_log\_group\_arn](#output\_lambda\_log\_group\_arn) | n/a |
| <a name="output_lambda_log_group_name"></a> [lambda\_log\_group\_name](#output\_lambda\_log\_group\_name) | n/a |
| <a name="output_lambda_role_arn"></a> [lambda\_role\_arn](#output\_lambda\_role\_arn) | n/a |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.46.0 |
| <a name="provider_aws.deploy_region"></a> [aws.deploy\_region](#provider\_aws.deploy\_region) | >=4.46.0 |
## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_function_extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_security_group.vpc_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.vpc_lambda_vpc_ingress_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpc_lambda_vpc_ingress_443_prefix_lists](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpc_lambda_vpc_ingress_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [archive_file.source_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_ec2_managed_prefix_list.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_ec2_managed_prefix_list.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_iam_policy_document.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_function_assumerole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
<!-- END_TF_DOCS -->