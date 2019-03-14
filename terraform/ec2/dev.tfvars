bucket  = "dj-terraform-backend-dev"
key     = "ec2/terraform.tfstate"
region  = "ap-northeast-1"
encrypt = true
dynamodb_table = "dj-TerraformStateLock-dev"
acl = "bucket-owner-full-control"
