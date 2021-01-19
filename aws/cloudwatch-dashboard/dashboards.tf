provider "grafana" {
  url    = "http://${var.grafana_ip}:3000"
  auth   = "admin:${var.grafana_password}"
}

resource "grafana_data_source" "cloudwatch" {
  type = "cloudwatch"
  name = "cloudwatch"

  json_data {
    default_region = "eu-west-1"
  }
}

resource "grafana_dashboard" "billing" {
  config_json = file("${path.module}/billing-dashboard.json")
}