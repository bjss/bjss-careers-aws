data "terraform_remote_state" "bootstrap" {
  backend = "s3"
  config = {
    bucket = "techtest-terraform-state-322411843910-eu-west-2"
    key    = "techtest/322411843910/eu-west-2/bootstrap.tfstate"
    region = "eu-west-2"
  }
}
