module "grafana" {
  source = "./grafana-server"

  instance_type = "t3.micro"
}

module "cloudwatch" {
  source = "./cloudwatch-dashboard"

  grafana_ip = module.grafana.ip
  grafana_password = module.grafana.password
}

terraform {
  backend "s3" {
    bucket = "terraform-course-example-bucket"
    key    = "infrastructure/monitoring/grafana/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-state"
  }
}

resource "aws_s3_bucket" "state" {
  bucket = "terraform-course-example-bucket"
  acl    = "private"

  tags = {
    Name        = "terraform-course-example-bucket"
  }

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "state" {
  name           = "terraform-state"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-state"
  }
}