terraform {
  backend "s3" {
    bucket = "dj-tf-backend-dev"
    key    = "eks/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

provider "aws" {
  version = ">= 2.15"
  region  = "ap-northeast-2"
}