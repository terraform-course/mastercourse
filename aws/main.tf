module "grafana" {
  source = "./grafana-server"

  instance_type = "t3.small"
}

module "cloudwatch" {
  source = "./cloudwatch-dashboard"

  grafana_ip = module.grafana.ip
  grafana_password = module.grafana.password
}
