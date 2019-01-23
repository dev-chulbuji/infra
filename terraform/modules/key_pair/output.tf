output "key_pair_name" {
  description = "생성된 키페어 이름"
  value = "${aws_key_pair.generated_key.key_name}"
}
