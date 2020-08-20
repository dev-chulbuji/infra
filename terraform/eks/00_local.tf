data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${local.cluster_version}-v*"]
  }
  most_recent = true
  owners      = ["602401143452"] # Amazon Account ID
}

locals {
  vpc_id = "vpc-0da2d3bc026bcff2f"

  subnet_ids = [
    "subnet-04c60bac97880936b",
    "subnet-0aa757ed15e430064"
  ]

  cluster_name = "eks-dev"

  cluster_version               = "1.17"
  cluster_private_access        = true
  cluster_enabled_log_types     = []
  cluster_log_retention_in_days = 90
  cluster_log_kms_key_id        = ""

  worker_instance_type     = "t3.large"
  worker_key_pair_name     = "dj"
  worker_ebs_volume_type   = "gp2"
  worker_ebs_volume_size   = 60
  worker_autoscale_min     = 1
  worker_autoscale_max     = 10
  worker_autoscale_desired = 3
  worker_instance_ami      = data.aws_ami.eks_worker.id
}
