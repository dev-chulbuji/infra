variable "region" {
  default = "ap-northeast-1"
}

variable "vpc_name" {
  default = "chulbuji"
}

variable "domain" {
  default = "tf-test"
}

variable "es_version" {
  default = "6.4"
}

variable "es_instance_type" {
  default = "m4.large.elasticsearch"
}

variable "ebs_volume_size" {
  default = 10
}

variable "ebs_volume_type" {
  type        = "string"
  default     = "gp2"
  description = "Storage type of EBS volumes"
}

variable "tags" {
  description = "모든 리소스에 추가되는 tag 맵"
  type        = "map"
}

