terraform {
  required_version = ">= 0.12"
}

module "eks_q" {
  source = "../modules/eks"

  vpc_id     = local.vpc_id
  subnet_ids = local.subnet_ids

  cluster_version                 = local.cluster_version
  cluster_name                    = local.cluster_name
  cluster_endpoint_private_access = local.cluster_private_access == true
  cluster_endpoint_public_access  = local.cluster_private_access == false
  cluster_enabled_log_types       = local.cluster_enabled_log_types
  cluster_log_retention_in_days   = local.cluster_log_retention_in_days
  cluster_log_kms_key_id          = local.cluster_log_kms_key_id

  worker_instance_type = local.worker_instance_type
  worker_key_pair_name = local.worker_key_pair_name
  worker_instance_ami  = local.worker_instance_ami

  worker_ebs_volume_type   = local.worker_ebs_volume_type
  worker_ebs_volume_size   = local.worker_ebs_volume_size
  worker_autoscale_min     = local.worker_autoscale_min
  worker_autoscale_max     = local.worker_autoscale_max
  worker_autoscale_desired = local.worker_autoscale_desired

  map_roles = []
  map_users = []

  common_tags = {
    "test" = "dj"
  }
}
