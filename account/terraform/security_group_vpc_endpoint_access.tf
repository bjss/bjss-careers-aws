# Endpoint security group
resource "aws_security_group" "vpc_endpoint_access" {
  name        = "${local.prefix}-endpoint-access"
  vpc_id      = module.vpc.vpc_id
  description = "Allows access to the endpoints"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "10.222.0.0/16"
    ]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "10.222.0.0/16"
    ]
  }
}
