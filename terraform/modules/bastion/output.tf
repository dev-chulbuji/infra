output "instance_id" {
  description = "Bastion EC2 instance ID"
  value       = "${aws_instance.bastion.id}"
}

output "bastion_sg_id" {
  description = "Bastion에 접속하는 SG ID"
  value       = ["${aws_security_group.bastion.id}"]
}

output "ssh_from_bastion_sg_id" {
  description = "Bastion을 통한 SSH 연결을 허용하는 SG ID"
  value       = ["${aws_security_group.ssh_from_bastion.id}"]
}

output "database_from_bastion_sg_id" {
  description = "Bastion을 통한 DATABASE 연결을 허용하는 SG ID"
  value       = ["${aws_security_group.database_from_bastion.id}"]
}

output "eip_id" {
  description = "Bastion에 할당된 EIP ID"
  value       = ["${aws_eip.bastion.id}"]
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = "${aws_instance.bastion.private_ip}"
}