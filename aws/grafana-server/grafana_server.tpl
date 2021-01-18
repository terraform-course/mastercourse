#!/bin/bash

yum update -y

cat <<EOF >> /etc/yum.repos.d/grafana.repo
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF

cat <<EOF >> /etc/grafana/grafana.ini
[security]
admin_user = admin
admin_password = "${grafana_password}"
EOF

yum install grafana -y

systemctl daemon-reload
systemctl start grafana-server