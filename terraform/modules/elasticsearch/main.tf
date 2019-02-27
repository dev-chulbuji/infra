resource "aws_security_group" "es" {
  name = "es-${var.domain_name}"
  vpc_id = "${data.aws_vpc.selected.id}"

  ingress {
    from_port = 0
    to_port = 6555
    protocol = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.selected.cidr_block}",
    ]
  }

  tags = "${merge(var.tags, map("Name", format("sg-es-%s", var.domain_name)))}"
}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "es" {
  depends_on = [
    "aws_iam_service_linked_role.es"]

  domain_name = "${var.domain_name}"
  elasticsearch_version = "${var.es_version}"

  encrypt_at_rest = {
    enabled = "${var.encrypt_at_rest}"
    kms_key_id = "${var.kms_key_id}"
  }

  cluster_config {
    instance_type = "${var.instance_type}"
    instance_count = "${var.instance_count}"
    dedicated_master_enabled = "${var.instance_count >= var.dedicated_master_threshold ? true : false}"
    dedicated_master_count = "${var.instance_count >= var.dedicated_master_threshold ? 3 : 0}"
    dedicated_master_type = "${var.instance_count >= var.dedicated_master_threshold ? (var.dedicated_master_type != "false" ? var.dedicated_master_type : var.instance_type) : ""}"
    zone_awareness_enabled = "${var.es_zone_awareness}"
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  log_publishing_options = "${var.log_publishing_options}"


  vpc_options = [
    {
      security_group_ids = [
        "${aws_security_group.es.id}"
      ]
      subnet_ids = [
        "subnet-0cc5116771be9364e"
      ]
    }]

  log_publishing_options = "${var.log_publishing_options}"

  node_to_node_encryption {
    enabled = "${var.node_to_node_encryption_enabled}"
  }

  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.snapshot_start_hour}"
  }

  tags = "${merge(var.tags, map("Name", format("es-%s", var.domain_name)))}"
}

resource "aws_elasticsearch_domain_policy" "es_management_access" {
  domain_name = "${var.domain_name}"
  access_policies = "${data.aws_iam_policy_document.es_management_access.json}"
}
