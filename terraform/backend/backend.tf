locals {
  region = "${terraform.workspace == "dev" ? "ap-northeast-1" : "ap-northeast-2"}"
  tier = "${terraform.workspace}"
}

provider "aws" {
  version = "~> 2.1"
  region = "${local.region}"
}

resource "aws_dynamodb_table" "dj-terraform_state_lock" {
  name = "dj-TerraformStateLock-${local.tier}"
  billing_mode   = "PROVISIONED"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  
  tags = {
    Name = "dj-terraform-state-lock-table-${local.tier}"
    "TerraformManaged" = "true"
  }
}

resource "aws_s3_bucket" "dj-terraform-logs" {
  bucket = "dj-terraform-log-${local.tier}"
  acl    = "log-delivery-write"
  region = "${local.region}"

  tags = {
    Name = "dj-terraform-state-log-${local.tier}"
    "TerraformManaged" = "true"
  }
}

resource "aws_s3_bucket" "dj-terraform-stat" {
  bucket = "dj-terraform-backend-${local.tier}"
  acl    = "private"
  region = "${local.region}"
  versioning {
    enabled = true
  }

  tags = {
    Name = "dj-terraform-state-${local.tier}"
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