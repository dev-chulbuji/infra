# cluster security group
resource "aws_security_group" "cluster" {
  name        = "${local.lower_name}-master-sg"
  description = "Cluster communication with worker nodes"

  vpc_id = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "sg-master-${local.lower_name}",
     "kubernetes.io/cluster/${local.lower_name}", "owned"
    )
  }"
}

resource "aws_security_group_rule" "cluster-ingress-node-https" {
  description              = "Allow node to communicate with the cluster API Server"
  security_group_id        = "${aws_security_group.cluster.id}"
  source_security_group_id = "${aws_security_group.worker.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster-ingress-admin-https" {
  description       = "Allow workstation to communicate with the cluster API Server"
  security_group_id = "${aws_security_group.cluster.id}"
  cidr_blocks       = "${var.allow_ip_address}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
}
