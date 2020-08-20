module "vpc" {
  source = "../modules/vpc"

  name = "dev"
  cidr = "172.17.0.0/16"

  azs                 = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets      = ["172.17.1.0/24", "172.17.2.0/24"]
  private_subnets     = ["172.17.101.0/24", "172.17.102.0/24"]
  database_subnets    = ["172.17.201.0/24", "172.17.202.0/24"]
  ingress_cidr_blocks = ["${var.office_cidr_blocks}"]

  database_ingress_ips = "${module.ec2.private_ip}"

  tags = {
    "TerraformManaged" = "true"
  }
}

module "bastion" {
  source = "../modules/bastion"
  name   = "bastion"

  instance_type = "t2.nano"
  keypair_name  = "${var.key_pair}"
  ami           = "${data.aws_ami.amazon_linux_nat.id}"

  vpc_id            = "${module.vpc.vpc_id}"
  availability_zone = "${module.vpc.azs[0]}"
  subnet_id         = "${module.vpc.public_subnets_ids[0]}"

  ingress_cidr_blocks = "${var.office_cidr_blocks}"

  tags = {
    "TerraformManaged" = "true"
  }
}

module "ec2" {
  source = "../modules/ec2"
  name   = "server"

  instance_type = "t2.micro"
  keypair_name  = "${var.key_pair}"
  ami           = "${data.aws_ami.ubuntu-18_04.id}"

  vpc_id            = "${module.vpc.vpc_id}"
  availability_zone = "${module.vpc.azs[0]}"
  subnet_id         = "${module.vpc.public_subnets_ids[0]}"

  ingress_sg_from_bastion  = "${module.bastion.ssh_from_bastion_sg_id}"
  ingress_http_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    "TerraformManaged" = "true"
  }
}

module "database" {
  source = "../modules/rds"

  name       = "chulbujidb"
  identifier = "chulbuji-db-instance"

  engine         = "postgres"
  engine_version = "10.4"
  username       = "chulbuji"
  password       = "chulbuji"

  db_instance_type = "db.t2.micro"

  ingress_sg_from_bastion = "${module.bastion.ssh_from_bastion_sg_id}"

  tags = {
    "TerraformManaged" = "true"
  }
}

