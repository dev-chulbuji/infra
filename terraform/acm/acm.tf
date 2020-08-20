provider "aws" {
  region = "us-east-1"
}

resource "aws_acm_certificate" "demo_sideeffect_kr" {
  domain_name       = "chulbuji.gq"
  validation_method = "EMAIL"
}