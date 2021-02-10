module "grafana" {
  source = "./grafana-server"

  instance_type = "t3.micro"
}

terraform {
  backend "remote" {
    organization = "terraform-course2021"

    workspaces {
      name = "mastercourse"
    }
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