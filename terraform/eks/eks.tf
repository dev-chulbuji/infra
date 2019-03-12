terraform {
  required_version = ">= 0.11.11"
  backend "s3" {
    bucket  = "dj-terraform-backend-dev"
    key     = "eks/terraform.tfstate"
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

  cluster-name = "chulbuji-eks-dev"
}

provider "aws" {
  version = "~> 2.1"
  region = "${local.region}"
}

module "eks" {
  source = "..\/modules\/eks"

  cluster_name = "chulbuji-eks"
  kubernetes_version = "1.11"

  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_ids = "${data.terraform_remote_state.vpc.private_subnets_ids}"
  allow_ip_address = ["0.0.0.0/0"]

  worker_instance_type = "t2.micro"
  worker_autoscale_enable = true
  worker_key_pair_name = "aws_key_pair_tokyo"
  worker_ebs_volume_type = "gp2"
  worker_ebs_volume_size = "10"
  worker_autoscale_min = "1"
  worker_autoscale_max = "5"
  worker_autoscale_desired = "5"

  map_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/SEOUL-DEV-DEMO-BASTION"
      username = "iam_role_bastion"
      group    = "system:masters"
    },
  ]

  map_users = [
    {
      user     = "user/admin"
      username = "admin"
      group    = "admin"
    },
  ]
}


