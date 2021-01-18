provider "grafana" {
  url    = "http://${aws_instance.grafana_server.public_ip}:3000"
  auth   = "admin:${random_password.password.result}"
}

resource "grafana_data_source" "cloudwatch" {
  type = "cloudwatch"
  name = "cloudwatch"

  json_data {
    default_region = "eu-west-1"
  }
}

resource "grafana_dashboard" "billing" {
  config_json = file("billing-dashboard.json")
}