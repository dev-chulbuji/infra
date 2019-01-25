## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| db\_instance\_type | db instance type | string | `db.t2.micro` | no |
| engine | db engine | string | `postgres` | no |
| engine\_version | db engine version | string | `10.4` | no |
| identifier | - | string | - | yes |
| ingress\_sg\_from\_bastion | SSH 접속을 허용할 CIDR block 리스트 | list | - | yes |
| name | - | string | - | yes |
| password | - | string | - | yes |
| tags | 모든 리소스에 추가되는 tag 맵 | map | - | yes |
| username | - | string | - | yes |

