data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc_name}"
  }
}

data "aws_subnet_ids" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"

  tags {
    Tier = "private"
  }
}


data "aws_iam_policy_document" "es_management_access" {
  statement {
    actions = [
      "es:*",
    ]

    resources = [
      "${aws_elasticsearch_domain.es.arn}",
      "${aws_elasticsearch_domain.es.arn}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
      "${distinct(compact(var.management_iam_roles))}"]
    }
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
