// 내 ip curl ifconfig.me
variable "office_cidr_blocks" {
  type = "list"

  default = [
    "124.53.127.62/32"
  ] # 이 값은 실제 접속을 허용할 IP를 넣어야 함
}