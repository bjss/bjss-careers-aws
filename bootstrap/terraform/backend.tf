terraform {
  backend "s3" {
    region         = "eu-west-2"
    bucket         = "techtest-terraform-state-322411843910-eu-west-2"
    key            = "techtest/322411843910/eu-west-2/bootstrap.tfstate"
    dynamodb_table = "techtest-terraform-statelock"
  }
}
