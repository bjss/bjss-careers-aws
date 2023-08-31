resource "kubernetes_config_map_v1_data" "main" {
  depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.main,
    aws_iam_role.eks_cluster,
    aws_iam_role.eks_node,
  ]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  force = true

  data = {
    mapRoles = <<YAML
- rolearn: ${aws_iam_role.eks_node.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
- rolearn: ${var.identifiers.account_admin_role_simple_arn}
  username: kubectl-access-user
  groups:
    - system:masters
- rolearn: ${var.identifiers.app_deployer_role_arn}
  username: kubectl-access-deploy
  groups:
    - system:masters
- rolearn: ${var.identifiers.candidates_role_arn}
  username: kubectl-access-candidate
YAML
  }
}
