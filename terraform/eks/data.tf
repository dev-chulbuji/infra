data "terraform_remote_state" "vpc" {
  backend = "s3"
  workspace = "${terraform.workspace}"
  config {
    bucket  = "dj-terraform-backend-dev"
    key     = "vpc/terraform.tfstate"
    region  = "${local.region}"
    encrypt = true
  }
}

data "aws_caller_identity" "current" {}