# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = "${module.vpc.vpc_id}"
}

output "public_subnets_ids" {
  description = "Public Subnet ID 리스트"
  value       = "${module.vpc.public_subnets_ids}"
}

output "private_subnets_ids" {
  description = "Public Subnet ID 리스트"
  value       = "${module.vpc.private_subnets_ids}"
}