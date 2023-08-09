# Bootstrap Terraform Configuration

This Terraform Configuration bootstraps the whole solution by creating the remote state S3 bucket, DynamoDB lock table, and KMS encryption key for the state.

This config must be run before anything else in the repo. Under normal circumstances it should only be run once.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS Account ID into which we are bootstrapping the project | `string` | `"322411843910"` | no |
| <a name="input_component"></a> [component](#input\_component) | Name of the terraform configuration. Ordinarily set via the default value | `string` | `"bootstrap"` | no |
| <a name="input_module"></a> [module](#input\_module) | Name of the local terraform module. Initialised to n/a outside of any modules | `string` | `"n/a"` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the Project we are bootstrapping. This will be used in the state bucket and lock table names | `string` | `"techtest"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS Region into which we are bootstrapping the project | `string` | `"eu-west-2"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_state_bucket_arn"></a> [state\_bucket\_arn](#output\_state\_bucket\_arn) | n/a |
| <a name="output_state_bucket_key"></a> [state\_bucket\_key](#output\_state\_bucket\_key) | n/a |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | n/a |
| <a name="output_state_lock_table_arn"></a> [state\_lock\_table\_arn](#output\_state\_lock\_table\_arn) | n/a |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.51.0 |
## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_statelock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_kms_key.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy_document.state_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.state_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
<!-- END_TF_DOCS -->