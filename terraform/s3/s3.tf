locals {
  region = "${terraform.workspace == "dev" ? "ap-northeast-1" : "ap-northeast-2"}"
}

provider "aws" {
  version = "~> 2.1"
  region = "${local.region}"
}

module "s3" {
  source = "../modules/s3"
  bucket = "dj-s3${terraform.workspace == "dev" ? "-dev" : "-${terraform.workspace}"}"
  region = "ap-northeast-1"
  acl = "public-read"
  versioning_enabled = "true"
} 
