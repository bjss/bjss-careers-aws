module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = local.prefix
  cidr = "10.222.0.0/16"
  azs  = data.aws_availability_zones.available.names

  private_subnets = [
    "10.222.0.0/24",
    "10.222.1.0/24",
    "10.222.2.0/24",
  ]

  public_subnets = [
    "10.222.3.0/24",
    "10.222.4.0/24",
    "10.222.5.0/24",
  ]

  manage_default_network_acl = true
  default_network_acl_name   = "default"
  default_network_acl_ingress = [
    {
      rule_no : 100
      action : "deny"
      protocol : "tcp"
      from_port : 22
      to_port : 22
      cidr_block : "0.0.0.0/0"
    },
    {
      rule_no : 110
      action : "deny"
      protocol : "tcp"
      from_port : 3389
      to_port : 3389
      cidr_block : "0.0.0.0/0"
    },
    {
      rule_no : 120
      action : "allow"
      protocol : "-1"
      from_port : 0
      to_port : 0
      cidr_block : "0.0.0.0/0"
    },
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = false

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  enable_flow_log = false
}
