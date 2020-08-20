
variable "identifier" {
}
variable "name" {
}

variable "engine" {
  description = "db engine"
  type        = "string"
  default     = "postgres"
}

variable "engine_version" {
  description = "db engine version"
  type        = "string"
  default     = "10.4"
}

variable "db_instance_type" {
  description = "db instance type"
  type        = "string"
  default     = "db.t2.micro"
}

variable "username" {
  type = "string"
}

variable "password" {
  type = "string"
}

variable "ingress_sg_from_bastion" {
  description = "SSH 접속을 허용할 CIDR block 리스트"
  type        = "list"
}

variable "tags" {
  description = "모든 리소스에 추가되는 tag 맵"
  type        = "map"
}