/*
* security group이 자동 생성 됩니다.
*/
provider "aws" {
  region = "ap-northeast-1"
}

module "es" {
  source = "../modules/elasticsearch"
  vpc_name = "chulbuji"
  domain_name = "chulbuji-dev"

  instance_count = 1
  instance_type = "t2.small.elasticsearch"
  dedicated_master_type = "t2.small.elasticsearch"
  es_zone_awareness = false
  ebs_volume_size = 10

  log_publishing_options = [
    //    {
    //      cloudwatch_log_group_arn = "arn:aws:logs:eu-central-1:604506250243:log-group:es:*"
    //      log_type = "INDEX_SLOW_LOGS"
    //      enabled = true
    //    },
    //    {
    //      cloudwatch_log_group_arn = "arn:aws:logs:eu-central-1:604506250243:log-group:es:*"
    //      log_type = "SEARCH_SLOW_LOGS"
    //      enabled = true
    //    },
    //    {
    //      cloudwatch_log_group_arn = "arn:aws:logs:eu-central-1:604506250243:log-group:es:*"
    //      log_type = "ES_APPLICATION_LOGS"
    //      enabled = true
    //    }
  ]
  tags = {
    "TerraformManaged" = "true"
  }
}
