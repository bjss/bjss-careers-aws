module "k8s" {
  source = "../../modules/k8s"

  module      = "k8s"
  identifiers = local.identifiers

  subnet_ids = data.terraform_remote_state.account.outputs.private_subnet_ids
}
