# SG for SSH Connect to EC2
resource "aws_security_group" "ec2" {
  name = "${var.name}"
  description = "sg for chulbuji ec2"
  vpc_id = "${data.aws_vpc.selected.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = "${var.allow_ssh_ip}"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = "${var.ingress_http_cidr_blocks}"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = "${var.ingress_http_cidr_blocks}"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", format("sg-%s", var.name)))}"
}

# EC2
resource "aws_instance" "ec2" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"

  availability_zone = "${var.availability_zone}"
  subnet_id = "${data.aws_subnet.selected.id}"

  key_name = "${var.keypair_name}"
  vpc_security_group_ids = [
    "${aws_security_group.ec2.id}"]
  associate_public_ip_address = true

  tags = "${merge(var.tags, map("Name", format("ec2-%s", var.name)))}"
}
