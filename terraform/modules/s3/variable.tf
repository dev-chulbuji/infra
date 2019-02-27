variable "bucket_name" {
  type = "string"
  description = "bucket name"
}

variable "region" {
  type = "string"
  description = "s3 region"
}

variable "acl" {
  type = "string"
  description = "s3 acl"
}

variable "versioning_enabled" {
  type = "string"
  default = "false"
}



