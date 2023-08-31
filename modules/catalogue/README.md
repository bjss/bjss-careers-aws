# Catalogue Terraform Module

This Terraform Module creates the image resizing catalogue. This is a DynamoDB table.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identifiers"></a> [identifiers](#input\_identifiers) | Bundle of identifiers useful throughout the application | `map(string)` | n/a | yes |
| <a name="input_module"></a> [module](#input\_module) | The shortname of this module. Can be overridden but provides a sensible default | `string` | `"cat"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalogue_table_arn"></a> [catalogue\_table\_arn](#output\_catalogue\_table\_arn) | n/a |
| <a name="output_catalogue_table_name"></a> [catalogue\_table\_name](#output\_catalogue\_table\_name) | n/a |
| <a name="output_catalogue_table_readwrite_policy_arn"></a> [catalogue\_table\_readwrite\_policy\_arn](#output\_catalogue\_table\_readwrite\_policy\_arn) | n/a |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.46.0 |
## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.catalogue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.catalogue_table_readwrite](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.catalogue_table_readwrite](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
<!-- END_TF_DOCS -->