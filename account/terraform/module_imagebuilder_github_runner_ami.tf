module "imagebuilder_github_runner_ami" {
  source = "git::https://github.com/mtonxbjss/terraform-aws-autoscaling-github-runners//modules/imagebuilder-github-runner-ami?ref=v1.0.1"

  ami_build_pipeline_cron_expression = "0 4 ? * MON *"
  ami_version_number                 = "1.0.0"

  github_job_image_ecr_account_id       = var.aws_account_id
  github_job_image_ecr_repository_names = ["${aws_ecr_repository.terraform.name}:latest"]
  github_runner_binary_version          = "2.307.1"

  imagebuilder_ec2_encryption                = "CMK"
  imagebuilder_ec2_instance_type             = "t3a.large"
  imagebuilder_ec2_root_volume_size          = 100
  imagebuilder_ec2_subnet_id                 = module.vpc.private_subnets[0]
  imagebuilder_ec2_terminate_on_failure      = false
  imagebuilder_ec2_vpc_id                    = module.vpc.vpc_id
  imagebuilder_log_bucket_encryption_key_arn = aws_kms_key.cicd.arn
  imagebuilder_log_bucket_name               = aws_s3_bucket.cicd.bucket
  imagebuilder_log_bucket_path               = "github-runner/ami-logs/github"

  iam_roles_with_admin_access_to_created_resources = [
    local.identifiers.account_deployer_role_arn,
    local.identifiers.account_admin_role_arn,
  ]

  permission_boundary_arn = aws_iam_policy.permissions_boundary.arn
  region                  = var.region
  runner_account_id       = var.aws_account_id
  unique_prefix           = local.prefix
}
