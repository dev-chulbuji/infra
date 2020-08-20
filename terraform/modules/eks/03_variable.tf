variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  description = "vpc id what cluster is located"
}

variable "subnet_ids" {
  description = "list of subnet Ids"
  type        = list(string)
}

variable "cluster_version" {
  default = "1.13"
}

variable "cluster_name" {
  description = "cluster name"
  type        = string
}

variable "cluster_endpoint_private_access" {
  default = true
}

variable "cluster_endpoint_public_access" {
  default = false
}

variable "cluster_enabled_log_types" {
  default     = []
  description = "A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
}

variable "cluster_log_retention_in_days" {
  default     = 90
  description = "Number of days to retain log events. Default retention - 90 days."
  type        = number
}

variable "cluster_log_kms_key_id" {
  default     = ""
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
  type        = string
}

variable "worker_instance_ami" {
  description = "worker node instance ami"
}

variable "worker_instance_type" {
  description = "worker node instance type"
  default     = "t2.micro"
}

variable "worker_key_pair_name" {
  description = "worker instance key pair"
}

variable "worker_ebs_volume_type" {
  description = "worker instance ebs volume type"
  default     = "gp2"
}

variable "worker_ebs_volume_size" {
  description = "worker instance ebs volume size"
  default     = "60"
}

variable "worker_autoscale_min" {
  default = "1"
}

variable "worker_autoscale_max" {
  default = "5"
}

variable "worker_autoscale_desired" {
  default = "5"
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type        = list(map(string))
  default     = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = list(map(string))
  default     = []
}