resource "aws_lb" "grafana" {
  name               = "grafana"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.grafana_lb.id]
  subnets            = data.aws_subnet_ids.default.ids
}

resource "aws_lb_listener" "grafana" {
  load_balancer_arn = aws_lb.grafana.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana.arn
  }
}

resource "aws_lb_target_group" "grafana" {
  name     = "grafana"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path = "/"
    port = 3000
    matcher = "200-399"
  }
}

resource "aws_lb_target_group_attachment" "grafana" {
  target_group_arn = aws_lb_target_group.grafana.arn
  target_id        = aws_instance.grafana_server.id
  port             = 3000
}

resource "aws_security_group" "grafana_lb" {
  name        = "grafana_lb"
  description = "Allow inbound traffic for Grafana LB"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP on port 80 from everywhere"
    from_port   = 80
    to_port     = 80
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
    Name = "grafana_lb"
  }
}