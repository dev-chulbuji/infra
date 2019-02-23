provider "aws" {
  region = "${var.region}"
}
module "vpc" {
  source = "../modules/vpc"

  name = "chulbuji"
  cidr = "172.17.0.0/16"

  azs              = ["${var.region}a", "${var.region}c"]
  public_subnets   = ["172.17.1.0/24", "172.17.2.0/24"]
  private_subnets  = ["172.17.101.0/24", "172.17.102.0/24"]
  database_subnets  = ["172.17.201.0/24", "172.17.202.0/24"]
  ingress_cidr_blocks = ["${var.office_cidr_blocks}"]
  
  tags = {
    "TerraformManaged" = "true"
  }
}