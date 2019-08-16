terraform {
  required_version = ">= 0.10.3" # introduction of Local Values configuration language feature
}
# VPC
resource "aws_vpc" "this" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}