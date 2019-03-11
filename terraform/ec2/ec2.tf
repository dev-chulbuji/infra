terraform {
  required_version = ">= 0.11.11"
  backend "s3" {
    bucket  = "dj-terraform-backend-dev"
    key     = "ec2/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
    dynamodb_table = "dj-TerraformStateLock-dev"
    acl = "bucket-owner-full-control"
  }
}

locals {
  tier = "${terraform.workspace}"
  region = "${terraform.workspace == "dev" ? "ap-northeast-1" : "ap-northeast-2"}"
  key = "${terraform.workspace == "dev" ? "aws_key_pair_tokyo" : "aws_key_pair_seoul"}"
}

provider "aws" {
  version = "~> 2.1"
  region = "${local.region}"
}

module "ec2" {
  source = "../modules/ec2"
  name = "server-${local.tier}"
  region = "${local.region}"

  vpc_name = "chulbuji"
  subnet_type = "public"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  instance_type = "t2.micro"
  keypair_name = "${local.key}"
  ami = "${data.aws_ami.ubuntu-18_04.id}"

  ingress_http_cidr_blocks = ["0.0.0.0/0"]
  allow_ssh_ip = ["0.0.0.0/0"]

  tags = {
    "Name" = "server-${local.tier}"
    "TerraformManaged" = "true"
  }
}
