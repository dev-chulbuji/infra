terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = ">= 2.15"
  region  = "ap-northeast-2"
}

provider "local" {
  version = ">= 1.3.0"
}

data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.cluster_version}-v*"]
  }

  most_recent = true

  # Owner ID of AWS EKS team
  owners = ["602401143452"]
}

data "template_file" "kube_config" {
  template = file("${path.module}/templates/kube_config.yaml.tpl")

  vars = {
    CERTIFICATE     = aws_eks_cluster.cluster.certificate_authority[0].data
    MASTER_ENDPOINT = aws_eks_cluster.cluster.endpoint
    CLUSTER_NAME    = local.lower_name
  }
}

data "template_file" "kube_config_secret" {
  template = file("${path.module}/templates/kube_config_secret.yaml.tpl")

  vars = {
    CLUSTER_NAME = local.lower_name
    ENCODED_TEXT = base64encode(data.template_file.kube_config.rendered)
  }
}

data "aws_caller_identity" "current" {
}

data "template_file" "map_roles" {
  count    = length(var.map_roles)
  template = file("${path.module}/templates/aws_auth-map_roles.yaml.tpl")

  vars = {
    rolearn  = var.map_roles[count.index]["rolearn"]
    username = var.map_roles[count.index]["username"]
    group    = var.map_roles[count.index]["group"]
  }
}

data "template_file" "map_users" {
  count    = length(var.map_users)
  template = file("${path.module}/templates/aws_auth-map_users.yaml.tpl")

  vars = {
    userid   = data.aws_caller_identity.current.account_id
    username = var.map_users[count.index]["username"]
    group    = var.map_users[count.index]["group"]
  }
}

data "template_file" "aws_auth" {
  template = file("${path.module}/templates/aws_auth.yaml.tpl")

  vars = {
    rolearn   = aws_iam_role.worker.arn
    map_roles = join("", data.template_file.map_roles.*.rendered)
    map_users = join("", data.template_file.map_users.*.rendered)
  }
}

data "template_file" "certificate" {
  template = file("${path.module}/templates/kabang-cert.tpl")
}

data "template_file" "userdata" {
  template = file("${path.module}/templates/userdata.sh.tpl")

  vars = {
    certificate = data.template_file.certificate.rendered
    cluster_name = aws_eks_cluster.cluster.name
    endpoint = aws_eks_cluster.cluster.endpoint
    cluster_auth_base64 = aws_eks_cluster.cluster.certificate_authority[0].data
  }
}
