data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*.1-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

resource "aws_instance" "grafana_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"

  tags = {
    Name = "Grafana Server"
  }

  user_data = file("grafana_server.sh")

  security_groups = [
    aws_security_group.grafana_server.name
  ]
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "grafana_server" {
  name        = "grafana_server"
  description = "Allow inbound traffic for Grafana Server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP on port 3000 from everywhere"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "grafana_server"
  }
}
