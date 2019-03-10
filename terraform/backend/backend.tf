locals {
  region = "ap-northeast-2"
}

provider "aws" {
  version = "~> 2.0"
  region = "${local.region}"
}

resource "aws_dynamodb_table" "dj-terraform_state_lock" {
  name = "dj-TerraformStateLock"
  billing_mode   = "PROVISIONED"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  
  tags = {
    Name = "dj-terraform-state-lock-table"
    "TerraformManaged" = "true"
  }
}

resource "aws_s3_bucket" "dj-terraform-logs" {
  bucket = "dj-terraform-log"
  acl    = "log-delivery-write"
  region = "${local.region}"

  tags = {
    Name = "dj-terraform-state-log"
    "TerraformManaged" = "true"
  }
}

resource "aws_s3_bucket" "dj-terraform-stat" {
  bucket = "dj-terraform-backend"
  acl    = "private"
  region = "${local.region}"
  versioning {
    enabled = true
  }

  tags = {
    Name = "dj-terraform-state"
    TerraformManaged = "true"
  }

  logging {
    target_bucket = "${aws_s3_bucket.dj-terraform-logs.id}"
    target_prefix = "log/"
  }

  lifecycle {
    prevent_destroy = true
  }
}