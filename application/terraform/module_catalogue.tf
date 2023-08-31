module "catalogue" {
  source = "../../modules/catalogue"

  module      = "cat"
  identifiers = local.identifiers
}
