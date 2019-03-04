data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc_name}"
  }
}

data "aws_subnet" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"

  tags {
    Tier = "${format("%s-%s", var.subnet_type, substr(element(split("-", var.availability_zone), 2), 1, 1))}"
  }
}

# subnet_type = "public"
# availability_zone = "ap-northeast-1a"
