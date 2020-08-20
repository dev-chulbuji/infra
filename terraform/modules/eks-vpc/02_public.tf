# internet gateway
resource "aws_internet_gateway" "this" {
  count = "${length(var.public_subnet_ips) > 0 ? 1 : 0}"

  vpc_id = "${aws_vpc.this.id}"

  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

resource "aws_network_acl" "public" {
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
    "${aws_subnet.public.*.id}",
  ]

  tags = "${merge(var.tags, map("Name", format("%s-public-nacl", var.name)))}"
}

# public subnet
resource "aws_subnet" "public" {
  count = "${length(var.public_subnet_ips)}"

  vpc_id                  = "${aws_vpc.this.id}"
  cidr_block              = "${var.public_subnet_ips[count.index]}"
  availability_zone       = "${var.azs[count.index]}"
  map_public_ip_on_launch = true

  tags = "${merge(
    var.tags,
    map("Name", format("%s-public-%s", var.name, var.azs[count.index])),
    map("kubernetes.io/role/elb", "1"),
    map("Tier", "public"),
  map("TierWithAZ", format("public-%s", substr(element(split("-", var.azs[count.index]), 2), 1, 1))))}"
}

# public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }

  tags = "${merge(var.tags, map("Name", format("%s-public-%s", var.name, element(var.azs, count.index))))}"
}

# route table association
resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnet_ips)}"

  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}