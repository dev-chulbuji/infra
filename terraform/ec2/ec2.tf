module "ec2" {
  source = "../modules/ec2"
  name = "server"
  region = "ap-northeast-1"

  vpc_name = "chulbuji"
  subnet_type = "public"
  availability_zone = "ap-northeast-1a"

  instance_type = "t2.micro"
  keypair_name = "aws_key_pair_tokyo"
  ami = "${data.aws_ami.ubuntu-18_04.id}"
  ingress_http_cidr_blocks = [
    "0.0.0.0/0"]

  allow_ssh_ip = [
    "0.0.0.0/0"]

  tags = {
    "TerraformManaged" = "true"
  }
}
