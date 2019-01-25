## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami | ec2 생성에 사용할 AMI | string | - | yes |
| availability\_zone | EC2 instance availability zone | string | - | yes |
| ingress\_http\_cidr\_blocks | http 접속을 허용할 CIDR block 리스트 | list | - | yes |
| ingress\_sg\_from\_bastion | SSH 접속을 허용할 CIDR block 리스트 | list | - | yes |
| instance\_type | EC2 instance type | string | `t2.nano` | no |
| keypair\_name | ec2가 사용할 keypair name | string | - | yes |
| name | 모듈에서 정의하는 모든 리소스 이름의 prefix | string | - | yes |
| subnet\_id | EC2 instance Subnet ID | string | - | yes |
| tags | 모든 리소스에 추가되는 tag 맵 | map | - | yes |
| vpc\_id | VPC ID | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| ec2\_sg\_id | EC2에 접속하는 SG ID |
| instance\_id | EC2 instance ID |
| private\_ip | List of private IP addresses assigned to the instances |

