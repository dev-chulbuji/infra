variable "kubernetes_version" {
  default = "1.11"
}

variable "cluster_name" {
  description = "cluster name"
  type = "string"
}

variable "vpc_id" {
  description = "vpc id what cluster is located"
}

variable "subnet_ids" {
  description = "list of subnet Ids"
  type        = "list"
}

variable "allow_ip_address" {
  description = "list of IP address to permit access"
  default     = ["0.0.0.0/0"]
  type        = "list"
}

variable "worker_instance_type" {
  description = "worker node instance type"
  default = "t2.micro"
}

variable "worker_autoscale_enable" {
  description = "is worker node autoscalable?"
  default = true
}

variable "worker_key_pair_name" {
  description = "worker instance key pair"
}

variable "worker_ebs_volume_type" {
  description = "worker instance ebs volume type"
  default = "gp2"
}

variable "worker_ebs_volume_size" {
  description = "worker instance ebs volume size"
  default = "60"
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
  type        = "list"
  default     = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = "list"
  default     = []
}