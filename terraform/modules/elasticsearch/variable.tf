variable "region" {
  default = "ap-northeast-1"
  description = "Elasticsearch가 위치할 region"
}

variable "domain_name" {
  default = "tf-test"
  description = "Elasticsearch domian name"
}

variable "vpc_name" {
  description = "vpc 이름"
  type = "string"
  default = "chulbuji"
}

variable "management_iam_roles" {
  description = "List of IAM role ARNs from which to permit management traffic (default ['*']).  Note that a client must match both the IP address and the IAM role patterns in order to be permitted access."
  type = "list"
  default = [
    "*"]
}

variable "encrypt_at_rest" {
  description = "Enable encrption at rest (only specific instance family types support it: m4, c4, r4, i2, i3 default: false)"
  default = false
}

variable "kms_key_id" {
  description = "KMS key used for elasticsearch"
  default = ""
}

variable "es_version" {
  default = "6.4"
  description = "EBS version"
}

variable "instance_type" {
  default = "m4.large.elasticsearch"
  description = "elasticsearch instance type"
}

variable "instance_count" {
  description = "Number of data nodes in the cluster (default 6)"
  default = 3
}

variable "dedicated_master_type" {
  description = "ES instance type to be used for dedicated masters (default same as instance_type)"
  default = false
}

variable "dedicated_master_threshold" {
  description = "전용 마스터 노드로 사용될 instance 수 default: 10"
  default = 10
}

variable "es_zone_awareness" {
  description = "Enable zone awareness for Elasticsearch cluster (default false)"
  default = "false"
}

variable "log_publishing_options" {
  description = "List of maps of options for publishing slow logs to CloudWatch Logs."
  type = "list"
  default = []
}

variable "node_to_node_encryption_enabled" {
  description = "Whether to enable node-to-node encryption."
  default = false
}

variable "snapshot_start_hour" {
  description = "Hour at which automated snapshots are taken, in UTC (default 0)"
  default = 23
}


variable "ebs_volume_size" {
  description = "EBS volume 사이즈"
  default = 10
}

variable "ebs_volume_type" {
  type = "string"
  default = "gp2"
  description = "EBS volume 타입"
}

variable "tags" {
  description = "모든 리소스에 추가되는 tag 맵"
  type = "map"
}

