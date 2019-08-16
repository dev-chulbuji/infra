# output
output "cluster_name" {
  value = "${element(concat(aws_eks_cluster.cluster.*.name, list("")), 0)}"
}

output "config" {
  value = "${local.config}"
}