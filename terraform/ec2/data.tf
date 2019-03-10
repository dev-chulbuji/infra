// ubuntu 18.04
data "aws_ami" "ubuntu-18_04" {
  most_recent = true
  owners = [
    "099720109477"]

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}


data "aws_availability_zones" "available" {}

data "aws_vpc" "selected" {
  tags = {
    name = "chulbuji"
  }
}