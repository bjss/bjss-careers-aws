module "autoscaling_github_runners" {
  source = "git::https://github.com/mtonxbjss/terraform-aws-autoscaling-github-runners?ref=v1.2.0"

  cicd_artifacts_bucket_name    = aws_s3_bucket.cicd.bucket
  cicd_artifacts_bucket_key_arn = aws_kms_key.cicd.arn

  ec2_dynamic_scaling_enabled = false
  ec2_github_runner_name      = "githubrunner"
  ec2_github_runner_tag_list  = "techtest"

  ec2_iam_role_extra_policy_attachments = [
    aws_iam_policy.administer_candidates.arn
  ]

  ec2_imagebuilder_image_arn          = module.imagebuilder_github_runner_ami.imagebuilder_image_arn_xxx
  ec2_maximum_concurrent_github_jobs  = 2
  ec2_nightly_shutdown_enabled        = true
  ec2_morning_scaleout_enabled        = true
  ec2_nightly_shutdown_scale_in_time  = "0 18 * * *"
  ec2_nightly_shutdown_scale_out_time = "0 7 * * MON-FRI"
  ec2_runner_role_tag                 = "TechTest GitHub Actions jobs"
  ec2_spot_instances_max_price        = 0.5
  ec2_spot_instances_preferred        = true
  ec2_subnet_ids                      = module.vpc.private_subnets

  ec2_terraform_deployment_roles = [
    local.identifiers.account_deployer_role_arn,
  ]

  ec2_vpc_id = module.vpc.vpc_id

  github_job_image_ecr_account = var.aws_account_id
  github_organization_url      = "https://github.com/bjss"
  github_repository_names      = ["bjss-careers-aws-dev", "bjss-careers-aws"]

  iam_roles_with_admin_access_to_created_resources = [
    local.identifiers.account_deployer_role_arn,
    local.identifiers.account_admin_role_arn,
  ]

  permission_boundary_arn = aws_iam_policy.permissions_boundary.arn
  region                  = var.region
  runner_account_id       = var.aws_account_id

  state_bucket_name    = data.terraform_remote_state.bootstrap.outputs.state_bucket_name
  state_bucket_key_arn = data.terraform_remote_state.bootstrap.outputs.state_bucket_key
  state_lock_table_arn = data.terraform_remote_state.bootstrap.outputs.state_lock_table_arn

  unique_prefix = local.prefix
}
