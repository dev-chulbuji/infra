// bastion instance
data "aws_ami" "amazon_linux_nat" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

// ubuntu 18.04
data "aws_ami" "ubuntu-18_04" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

// 내 ip curl ifconfig.me
variable "office_cidr_blocks" {
  type = "list"

  default = [
    "124.53.127.62/32"
  ] # 이 값은 실제 접속을 허용할 IP를 넣어야 함
}

variable "key_pair" {
  type = "string"
  value = "dev_chulbuji_test"
}
