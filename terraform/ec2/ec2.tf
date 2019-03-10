terraform {
  backend "s3" {
    bucket  = "dj-terraform-backend"
    key     = "ec2/terraform.tfstate"
    region  = "ap-northeast-2"
    encrypt = true
  }
}

locals {
  region = "ap-northeast-2"
}

provider "aws" {
  version = "~> 2.0"
  region = "${local.region}"
}

module "ec2" {
  source = "../modules/ec2"
  name = "server"
  region = "${local.region}"

  vpc_name = "bastion"
  subnet_type = "public"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  instance_type = "t2.micro"
  keypair_name = "aws_key_pair_seoul"
  ami = "${data.aws_ami.ubuntu-18_04.id}"

  ingress_http_cidr_blocks = ["0.0.0.0/0"]
  allow_ssh_ip = ["0.0.0.0/0"]

  tags = {
    "Name" = "bastion"
    "TerraformManaged" = "true"
  }
}
