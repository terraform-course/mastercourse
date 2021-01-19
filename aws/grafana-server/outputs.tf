output "ip" {
  value = aws_instance.grafana_server.public_ip
}

output "password" {
  value = random_password.password.result
}
