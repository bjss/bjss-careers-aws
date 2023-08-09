resource "aws_route53_zone" "private" {
  name = "private.techtest.bjsscareers.co.uk"
  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
