## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami | bastion 생성에 사용할 AMI | string | - | yes |
| availability\_zone | bastion EC2 instance availability zone | string | - | yes |
| ingress\_cidr\_blocks | bastion SSH 접속을 허용할 CIDR block 리스트 | list | - | yes |
| instance\_type | bastion EC2 instance type | string | `t2.nano` | no |
| keypair\_name | bastion이 사용할 keypair name | string | - | yes |
| name | 모듈에서 정의하는 모든 리소스 이름의 prefix | string | - | yes |
| subnet\_id | bastion EC2 instance Subnet ID | string | - | yes |
| tags | 모든 리소스에 추가되는 tag 맵 | map | - | yes |
| vpc\_id | VPC ID | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_sg\_id | Bastion에 접속하는 SG ID |
| database\_from\_bastion\_sg\_id | Bastion을 통한 DATABASE 연결을 허용하는 SG ID |
| eip\_id | Bastion에 할당된 EIP ID |
| instance\_id | Bastion EC2 instance ID |
| private\_ip | List of private IP addresses assigned to the instances |
| ssh\_from\_bastion\_sg\_id | Bastion을 통한 SSH 연결을 허용하는 SG ID |

