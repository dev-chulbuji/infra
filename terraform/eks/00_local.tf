locals {
  vpc_id = ""

  subnet_ids = [
  ]

  cluster_name = "eks-prd"

  cluster_version = "1.13"
  cluster_private_access = true
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager","scheduler"]
  cluster_log_retention_in_days = 90
  cluster_log_kms_key_id = ""

  worker_instance_type = "t3.large"
  worker_key_pair_name = ""
  worker_ebs_volume_type = "gp2"
  worker_ebs_volume_size = 60
  worker_autoscale_min = 1
  worker_autoscale_max = 10
  worker_autoscale_desired = 3
}
