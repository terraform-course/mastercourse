output "alb_dns" {
  value = aws_lb.grafana.dns_name
}

output "password" {
  value = random_password.password.result
}
