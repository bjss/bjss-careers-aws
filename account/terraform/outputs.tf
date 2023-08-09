output "workspace" {
  value = terraform.workspace
}

output "environment" {
  value = local.environment
}

output "prefix" {
  value = local.prefix
}

output "account_deployer_role_arn" {
  value = local.identifiers.account_deployer_role_arn
}

output "permissions_boundary_arn" {
  value = aws_iam_policy.permissions_boundary.arn
}

output "github_runner_role_arn" {
  value = module.autoscaling_github_runners.instance_role_arn
}

output "cicd_bucket_name" {
  value = aws_s3_bucket.cicd.bucket
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "candidates_role_arn" {
  value = aws_iam_role.candidates.arn
}

output "private_hosted_zone_id" {
  value = aws_route53_zone.private.zone_id
}

output "nat_gateway_public_ips" {
  value = module.vpc.nat_public_ips
}
