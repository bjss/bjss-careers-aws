# Website Terraform Module

This Module generates the website for the application based on the input parameters. 

Using other modules, this module creates: 

- Static CDN Origin (S3): a bucket that is populated with the files found in the `static_pages` subdirectory
- Dynamic CDN Origin (API Gateway): an API that is defined by the OpenApi3.0 spec in the `openapi_specs` subdirectory and fulfilled by lambda functions
- CDN (CloudFront): a distribution that provides access to the S3 and API origins using a domain name and TLS certificate
- Serverless Functions (Lambda): whose node-js content is in the `lamdba_content` subdirectory

This module also creates the environment-level DNS Zone, creates the Origin Access Identity used to link CloudFront to S3 and API Gateway, and also implements the S3 bucket notifications that trigger image resizing activity to begin.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalogue_table_arn"></a> [catalogue\_table\_arn](#input\_catalogue\_table\_arn) | ARN of the DynamoDB catalogue table to update each time an image is written to S3 | `string` | n/a | yes |
| <a name="input_catalogue_table_name"></a> [catalogue\_table\_name](#input\_catalogue\_table\_name) | Name of the DynamoDB catalogue table to update each time an image is written to S3 | `string` | n/a | yes |
| <a name="input_catalogue_table_readwrite_policy_arn"></a> [catalogue\_table\_readwrite\_policy\_arn](#input\_catalogue\_table\_readwrite\_policy\_arn) | ARN of the IAM Policy that allows the DynamoDB catalogue table to be updated | `string` | n/a | yes |
| <a name="input_identifiers"></a> [identifiers](#input\_identifiers) | Bundle of identifiers useful throughout the application | `map(string)` | n/a | yes |
| <a name="input_ip_allow_list"></a> [ip\_allow\_list](#input\_ip\_allow\_list) | IP Addresses that are allowed to access this application | `list(string)` | `[]` | no |
| <a name="input_module"></a> [module](#input\_module) | The shortname of this module | `string` | `"web"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block of the VPC to use for any VPC-attached lambdas | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC to use for any VPC-attached lambdas | `string` | n/a | yes |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | Subnet IDs of the VPC to use for any VPC-attached lambdas | `list(string)` | n/a | yes |
## Outputs

No outputs.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.46.0 |
## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_origin_access_identity.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_iam_policy.basic_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_lambda_permission.image_bucket_new_objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_route53_record.environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_s3_bucket_notification.update_catalogue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_iam_policy_document.basic_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.bjsscareers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
<!-- END_TF_DOCS -->