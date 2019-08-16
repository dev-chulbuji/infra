variable "name" {
  description = "vpc name"
  type        = "string"
}

variable "cidr" {
  description = "vpc cidr"
  type        = "string"
}

variable "public_subnet_ips" {
  description = "public subent ip list"
  type        = "list"
}

variable "private_subnet_ips" {
  description = "private subnet ip list"
  type        = "list"
}

variable "azs" {
  description = "availability zones list"
  type        = "list"
}

variable "tags" {
  description = "tag map that all resources are attacted"
  type        = "map"
}

variable "ingress_cidr_blocks" {
  description = "list of IP address to permit access"
  type        = "list"
}