module "website" {
  source = "../../modules/website"

  depends_on = [
    module.catalogue,
  ]

  providers = {
    aws           = aws,
    aws.us-east-1 = aws.us-east-1
  }

  module      = "web"
  identifiers = local.identifiers
  ip_allow_list = length(var.ip_allow_list) == 0 ? [] : flatten([
    local.nat_gateway_public_ips_with_cidr_suffix,
    var.ip_allow_list
  ])

  catalogue_table_name                 = module.catalogue.catalogue_table_name
  catalogue_table_arn                  = module.catalogue.catalogue_table_arn
  catalogue_table_readwrite_policy_arn = module.catalogue.catalogue_table_readwrite_policy_arn

  vpc_id         = data.terraform_remote_state.account.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.account.outputs.vpc_cidr_block
  vpc_subnet_ids = data.terraform_remote_state.account.outputs.private_subnet_ids
}
