resource "aws_db_instance" "db" {
  identifier = "${var.identifier}"
  name       = "${var.name}"

  allocated_storage   = 8
  engine              = "${var.engine}"
  engine_version      = "${var.engine_version}"
  instance_class      = "${var.db_instance_type}"
  username            = "${var.username}"
  password            = "${var.password}"
  skip_final_snapshot = true

  vpc_security_group_ids = ["${var.ingress_sg_from_bastion}"]

  tags = "${merge(var.tags, map("Name", format("db-%s", var.name)))}"
}