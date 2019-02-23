variable "region" {
  default = "ap-northeast-1"
  description = "Elasticsearch가 위치할 region"
}

variable "vpc_name" {
  default = "chulbuji"
  description = "Elasticsearch가 위치할 VPC 이름"
}

variable "domain" {
  default = "tf-test"
  description = "Elasticsearch domian name"
}

variable "es_version" {
  default = "6.4"
  description = "EBS version"
}

variable "es_instance_type" {
  default = "m4.large.elasticsearch"
  description = "EBS instance type"
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

