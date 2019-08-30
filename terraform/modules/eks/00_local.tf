# locals

locals {
  upper_name = upper(var.cluster_name)
  lower_name = lower(var.cluster_name)
}

locals {
  worker_tags = [
    {
      key                 = "Name"
      value               = "${local.lower_name}-worker"
      propagate_at_launch = true
    },
    {
      key                 = "KubernetesCluster"
      value               = local.lower_name
      propagate_at_launch = true
    },
    {
      key                 = "kubernetes.io/cluster/${local.lower_name}"
      value               = "owned"
      propagate_at_launch = true
    },
    {
      key                 = "k8s.io/cluster-autoscaler/enabled"
      value               = "1"
      propagate_at_launch = true
    }
  ]
}

locals {
  userdata = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' \
  --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority[0].data}' \
  '${local.lower_name}'
EOF

}

locals {
  config = <<EOF
##################################################################################
cluster_name = ${element(concat(aws_eks_cluster.cluster.*.name, [""]), 0)}

# kube config
mkdir -p ~/.kube && cp result=$cluster_name/kube_config.yaml ~/.kube/config

# update aws-node for private certificate for aws-api-proxy
kubectl apply -f ./config/ds-aws-node.yaml

# apply EKS authentication files
kubectl apply -f result=$cluster_name/aws_auth.yaml
##################################################################################
EOF

}

