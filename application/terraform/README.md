# Application Terraform Configuration

This Terraform Configuration deploys a single image resizing application environment. Every environment is identical to every other environment, but you can have as many of them as you please (or as many as your AWS account limits will allow). The name of the environment is assumed from the name of the Terraform Workspace selected at deployment-time.

This Terraform Configuration doesn't create any resources in its own right, it simply calls a series of modules that create the resources we need. Those modules are all hosted inside this repo: 

- website
- catalogue
- k8s

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS Account ID into which we are deploying | `string` | `"322411843910"` | no |
| <a name="input_component"></a> [component](#input\_component) | Name of the terraform configuration. Ordinarily set via the default value. This will be used to name resources | `string` | `"app"` | no |
| <a name="input_ip_allow_list"></a> [ip\_allow\_list](#input\_ip\_allow\_list) | IP Addresses that are allowed to access this application. Any empty list means no allowlist is applied | `list(string)` | `[]` | no |
| <a name="input_module"></a> [module](#input\_module) | Name of the local terraform module. This will be used to name resources. Initialised to n/a outside of any modules | `string` | `"n/a"` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the Project. This will be used to name resources created by this Terraform configuration | `string` | `"techtest"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS Region into which we are deploying | `string` | `"eu-west-2"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_administrator_role_arn"></a> [administrator\_role\_arn](#output\_administrator\_role\_arn) | n/a |
| <a name="output_candidates_role_arn"></a> [candidates\_role\_arn](#output\_candidates\_role\_arn) | n/a |
| <a name="output_environment"></a> [environment](#output\_environment) | n/a |
| <a name="output_k8s_cluster_name"></a> [k8s\_cluster\_name](#output\_k8s\_cluster\_name) | n/a |
| <a name="output_k8s_node_role_arn"></a> [k8s\_node\_role\_arn](#output\_k8s\_node\_role\_arn) | n/a |
| <a name="output_private_hosted_zone_id"></a> [private\_hosted\_zone\_id](#output\_private\_hosted\_zone\_id) | n/a |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.account](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
<!-- END_TF_DOCS -->