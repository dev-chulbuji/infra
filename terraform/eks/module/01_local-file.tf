# local file
resource "local_file" "aws_auth" {
  content  = data.template_file.aws_auth.rendered
  filename = "${path.cwd}/result-${var.cluster_name}/aws_auth.yaml"
}

resource "local_file" "kube_config" {
  content  = data.template_file.kube_config.rendered
  filename = "${path.cwd}/result-${var.cluster_name}/kube_config.yaml"
}

resource "local_file" "kube_config_secret" {
  content  = data.template_file.kube_config_secret.rendered
  filename = "${path.cwd}/result-${var.cluster_name}/kube_config_secret.yaml"
}