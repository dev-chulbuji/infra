// ubuntu 18.04
data "aws_ami" "ubuntu-18_04" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

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

data "aws_availability_zones" "available" {}