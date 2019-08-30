# output
output "cluster_name" {
  value = element(concat(aws_eks_cluster.cluster.*.name, [""]), 0)
}

output "config" {
  value = local.config
}

