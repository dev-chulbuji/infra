# cluster security group
resource "aws_security_group" "cluster" {
  name   = "${local.lower_name}-cluster"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      "Name" = "${local.lower_name}-cluster"
    },
    local.tags,
  )
}

resource "aws_security_group_rule" "cluster-ingress-node-https" {
  description              = "Allow node to communicate with the cluster API Server"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.workers.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  type                     = "ingress"
}

