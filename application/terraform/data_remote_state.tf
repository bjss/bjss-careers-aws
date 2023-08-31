data "terraform_remote_state" "account" {
  backend = "s3"
  config = {
    bucket = "techtest-terraform-state-322411843910-eu-west-2"
    key    = "techtest/322411843910/eu-west-2/account.tfstate"
    region = "eu-west-2"
  }
}
