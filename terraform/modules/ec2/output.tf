output "instance_id" {
  description = "EC2 instance ID"
  value       = "${aws_instance.ec2.id}"
}

output "ec2_sg_id" {
  description = "EC2에 접속하는 SG ID"
  value       = ["${aws_security_group.ec2.id}"]
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = "${aws_instance.ec2.private_ip}"
}