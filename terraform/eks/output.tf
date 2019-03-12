output "cluster_name" {
  value = "${module.eks.cluster_name}"
}

output "config" {
  value = "${module.eks.config}"
}