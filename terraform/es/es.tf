module "elasticsearch" {
  source = "../modules/elasticsearch"
  region = "ap-northeast-1"
  vpc_name = "chulbuji"
  domain = "chulbuji"

  es_version = "6.4"
  es_instance_type = "m4.large.elasticsearch"

  ebs_volume_size = 10
  ebs_volume_type = "gp2"

  tags = {
    "TerraformManaged" = "true"
  }
}