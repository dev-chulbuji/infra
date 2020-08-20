terraform {
    backend "s3" {
        bucket  = "mmt-yata-infra"
        key     = "eks-cluster/terraform.tfstate"
        region  = "ap-northeast-2"
        encrypt = true
    }
}

resource "aws_s3_bucket" "s3" {
  bucket = "${var.bucket_name}"
  region = "${var.region}"
  acl = "${var.acl}"

  versioning {
    enabled = "${var.versioning_enabled}"
  }
}

resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  statement = [{
    actions = ["s3:*"]

    resources = ["${aws_s3_bucket.s3.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }]
}