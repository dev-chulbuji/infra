provider "aws" {
  region = "ap-northeast-1"
}

module "s3" {
  source = "../modules/s3"
  bucket_name = "chulbuji-helm-repo"
  region = "ap-northeast-1"
  acl = "public-read"
  versioning_enabled = "true"
} 
