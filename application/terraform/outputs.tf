output "candidates_role_arn" {
  value = local.identifiers.candidates_role_arn
}

output "administrator_role_arn" {
  value = local.identifiers.account_admin_role_arn
}

output "k8s_node_role_arn" {
  value = module.k8s.node_role_arn
}

output "k8s_cluster_name" {
  value = module.k8s.cluster_name
}

output "environment" {
  value = local.environment
}

output "private_hosted_zone_id" {
  value = data.terraform_remote_state.account.outputs.private_hosted_zone_id
}
