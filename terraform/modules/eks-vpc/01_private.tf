resource "aws_network_acl" "private" {
  vpc_id = "${aws_vpc.this.id}"

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }


  subnet_ids = [
    "${aws_subnet.private.*.id}",
  ]

  tags = "${merge(var.tags, map("Name", format("%s-private-nacl", var.name)))}"
}

# private subnet
resource "aws_subnet" "private" {
  count = "${length(var.private_subnet_ips)}"

  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${var.private_subnet_ips[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  map_public_ip_on_launch = false

  tags = "${merge(
            var.tags,
            map("Name", format("%s-private-%s", var.name, var.azs[count.index])),
            map("kubernetes.io/role/internal-elb", "1"),
            map("Tier", "private"),
            map("TierWithAZ", format("private-%s", substr(element(split("-", var.azs[count.index]), 2), 1, 1))))}"
}

# EIP for NAT gateway
resource "aws_eip" "nat" {
  count = "${length(var.azs)}"
  vpc = true
  tags = "${merge(map("Name", format("%s-%s", var.name, element(var.azs, count.index))), var.tags)}"
}

# NAT gateway
resource "aws_nat_gateway" "this" {
  count = "${length(var.azs)}"

  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"

  depends_on = ["aws_internet_gateway.this"]

  tags = "${merge(map("Name", format("%s-%s", var.name, element(var.azs, count.index))), var.tags)}"
}

# private route table
resource "aws_route_table" "private" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.this.*.id[count.index]}"
  }

  tags = "${merge(var.tags, map("Name", format("%s-private-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_route_table_association" "private" {
  count = "${length(var.private_subnet_ips)}"

  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}