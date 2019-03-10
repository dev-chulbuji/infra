terraform {
  backend "s3" {
    bucket  = "dj-terraform-backend-dev"
    key     = "s3bucket/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
    dynamodb_table = "dj-TerraformStateLock-dev"
    acl = "bucket-owner-full-control"
  }
}

locals {
  tier = "${terraform.workspace}"
  region = "${terraform.workspace == "dev" ? "ap-northeast-1" : "ap-northeast-2"}"
}

provider "aws" {
  version = "~> 2.1"
  region = "${local.region}"
}

module "s3" {
  source = "../modules/s3"
  bucket_name = "dj-s3-${local.tier}"
  region = "${local.region}"
  acl = "public-read"
  versioning_enabled = "true"
} 
