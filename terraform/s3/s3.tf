locals {
  region = "ap-northeast-1"
}

provider "aws" {
  version = "~> 2.1"
  region = "${local.region}"
}

module "s3" {
  source = "../modules/s3"
  bucket_name = "dj-s3-1"
  region = "ap-northeast-1"
  acl = "public-read"
  versioning_enabled = "true"
} 
