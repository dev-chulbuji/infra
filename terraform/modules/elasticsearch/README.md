## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dedicated\_master\_threshold | 전용 마스터 노드로 사용될 instance 수 default: 10 | string | `"10"` | no |
| dedicated\_master\_type | ES instance type to be used for dedicated masters (default same as instance_type) | string | `"false"` | no |
| domain\_name | Elasticsearch domian name | string | `"tf-test"` | no |
| ebs\_volume\_size | EBS volume 사이즈 | string | `"10"` | no |
| ebs\_volume\_type | EBS volume 타입 | string | `"gp2"` | no |
| encrypt\_at\_rest | Enable encrption at rest (only specific instance family types support it: m4, c4, r4, i2, i3 default: false) | string | `"false"` | no |
| es\_version | EBS version | string | `"6.4"` | no |
| es\_zone\_awareness | Enable zone awareness for Elasticsearch cluster (default false) | string | `"false"` | no |
| instance\_count | Number of data nodes in the cluster (default 6) | string | `"3"` | no |
| instance\_type | elasticsearch instance type | string | `"m4.large.elasticsearch"` | no |
| kms\_key\_id | KMS key used for elasticsearch | string | `""` | no |
| log\_publishing\_options | List of maps of options for publishing slow logs to CloudWatch Logs. | list | `<list>` | no |
| management\_iam\_roles | List of IAM role ARNs from which to permit management traffic (default ['*']).  Note that a client must match both the IP address and the IAM role patterns in order to be permitted access. | list | `<list>` | no |
| node\_to\_node\_encryption\_enabled | Whether to enable node-to-node encryption. | string | `"false"` | no |
| region | Elasticsearch가 위치할 region | string | `"ap-northeast-1"` | no |
| snapshot\_start\_hour | Hour at which automated snapshots are taken, in UTC (default 0) | string | `"23"` | no |
| tags | 모든 리소스에 추가되는 tag 맵 | map | n/a | yes |
| vpc\_name | vpc 이름 | string | `"chulbuji"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | Amazon Resource Name (ARN) of the domain |
| domain\_id | Unique identifier for the domain |
| domain\_name | The name of the Elasticsearch domain |
| endpoint | Domain-specific endpoint used to submit index, search, and data upload requests |
| kibana\_endpoint | Domain-specific endpoint for kibana without https scheme |