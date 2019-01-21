## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| azs | 사용할 availability zones 리스트 | list | - | yes |
| cidr | VPC에 할당한 CIDR block | string | - | yes |
| database\_subnets | Database Subnet IP 리스트 | list | - | yes |
| name | 모듈에서 정의하는 모든 리소스 이름의 prefix | string | - | yes |
| private\_subnets | Private Subnet IP 리스트 | list | - | yes |
| public\_subnets | Public Subnet IP 리스트 | list | - | yes |
| tags | 모든 리소스에 추가되는 tag 맵 | map | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_subnet\_group\_id | Database Subnet Group ID |
| database\_subnets\_ids | Database Subnet ID 리스트 |
| default\_network\_acl\_id | VPC default network ACL ID |
| default\_security\_group\_id | VPC default Security Group ID |
| igw\_id | Interget Gateway ID |
| nat\_ids | NAT Gateway에 할당된 EIP ID 리스트 |
| nat\_public\_ips | NAT Gateway에 할당된 EIP 리스트 |
| natgw\_ids | NAT Gateway ID 리스트 |
| private\_route\_table\_ids | Private Route Table ID 리스트 |
| private\_subnets\_ids | Private Subnet ID 리스트 |
| public\_route\_table\_ids | Public Route Table ID 리스트 |
| public\_subnets\_ids | Public Subnet ID 리스트 |
| vpc\_cidr\_block | VPC에 할당한 CIDR block |
| vpc\_id | VPC ID |