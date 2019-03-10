locals {
  tier = "${terraform.workspace}"
  region = "${terraform.workspace == "dev" ? "ap-northeast-1" : "ap-northeast-2"}"
}

terraform {
  backend "s3" {
    bucket  = "dj-terraform-backend-dev"
    key     = "vpc/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
    dynamodb_table = "dj-TerraformStateLock-dev"
    acl = "bucket-owner-full-control"
  }
}

provider "aws" {
  version = "~> 2.1"
  region = "${local.region}"
}

data "aws_availability_zones" "available" {}

data "external" "myip" {
  program = ["sh", "get_my_ip.sh" ]
}

module "vpc" {
  source = "../modules/vpc"

  name = "chulbuji"
  cidr = "172.17.0.0/16"

  azs              = "${slice(data.aws_availability_zones.available.names, 0, 2)}"
  public_subnets   = ["172.17.1.0/24", "172.17.2.0/24"]
  private_subnets  = ["172.17.101.0/24", "172.17.102.0/24"]
  database_subnets  = ["172.17.201.0/24", "172.17.202.0/24"]
  ingress_cidr_blocks = ["${data.external.myip.ip}"]
  
  tags = {
    "TerraformManaged" = "true"
  }
}