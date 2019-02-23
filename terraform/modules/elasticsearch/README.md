## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domain | Elasticsearch domian name | string | `tf-test` | no |
| ebs\_volume\_size | EBS volume 사이즈 | string | `10` | no |
| ebs\_volume\_type | EBS volume 타입 | string | `gp2` | no |
| es\_instance\_type | EBS instance type | string | `m4.large.elasticsearch` | no |
| es\_version | EBS version | string | `6.4` | no |
| region | Elasticsearch가 위치할 region | string | `ap-northeast-1` | no |
| tags | 모든 리소스에 추가되는 tag 맵 | map | - | yes |
| vpc\_name | Elasticsearch가 위치할 VPC 이름 | string | `chulbuji` | no |

## Outputs

| Name | Description |
|------|-------------|
| ElasticSearch Endpoint | - |
| ElasticSearch Kibana Endpoint | - |
