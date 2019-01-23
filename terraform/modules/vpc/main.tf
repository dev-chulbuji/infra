# VPC
resource "aws_vpc" "this" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

# internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

# default network ACL
resource "aws_network_acl" "dev_public_nacl" {
  vpc_id = "${aws_vpc.this.id}"

  ingress {
    protocol   = "tcp"
    rule_no    = 1
    action     = "allow"
    cidr_block = "61.82.87.247/32"
    from_port  = 22
    to_port    = 22
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 2
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 3
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  subnet_ids = [
    "${aws_subnet.public.*.id}",
  ]

  tags = "${merge(var.tags, map("Name", format("%s-public-nacl", var.name)))}"
}

resource "aws_network_acl" "dev_private_nacl" {
  vpc_id = "${aws_vpc.this.id}"

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  subnet_ids = [
    "${aws_subnet.private.*.id}",
  ]

  tags = "${merge(var.tags, map("Name", format("%s-private-nacl", var.name)))}"
}

resource "aws_network_acl" "dev_database_nacl" {
  vpc_id = "${aws_vpc.this.id}"

  subnet_ids = [
    "${aws_subnet.database.*.id}",
  ]

  tags = "${merge(var.tags, map("Name", format("%s-database-nacl", var.name)))}"
}

# public subnet
resource "aws_subnet" "public" {
  count = "${length(var.public_subnets)}"

  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s-public-%s", var.name, var.azs[count.index])))}"
}

# private subnet
resource "aws_subnet" "private" {
  count = "${length(var.private_subnets)}"

  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s-private-%s", var.name, var.azs[count.index])))}"
}

# private database subnet
resource "aws_subnet" "database" {
  count = "${length(var.database_subnets)}"

  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${var.database_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s-db-%s", var.name, var.azs[count.index])))}"
}

resource "aws_db_subnet_group" "database" {
  count = "${length(var.database_subnets) > 0 ? 1 : 0}"

  name        = "${var.name}"
  description = "Database subnet group for ${var.name}"
  subnet_ids  = ["${aws_subnet.database.*.id}"]

  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}


# EIP for NAT gateway
resource "aws_eip" "nat" {
  count = "${length(var.azs)}"

  vpc = true
}

# NAT gateway
resource "aws_nat_gateway" "this" {
  count = "${length(var.azs)}"

  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"
}

# public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }

  tags = "${merge(var.tags, map("Name", format("%s-public", var.name)))}"
}

# private route table
resource "aws_route_table" "private" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.this.*.id[count.index]}"
  }

  tags = "${merge(var.tags, map("Name", format("%s-private-%s", var.name, var.azs[count.index])))}"
}

# route table association
resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets)}"

  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count = "${length(var.private_subnets)}"

  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}

resource "aws_route_table_association" "database" {
  count = "${length(var.database_subnets)}"

  subnet_id      = "${aws_subnet.database.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}