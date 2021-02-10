resource "digitalocean_droplet" "web" {
  name   = "web-1"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-18-04-x64"
  region = "nyc3"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}

resource "digitalocean_loadbalancer" "public" {
  name   = "loadbalancer-1"
  region = "nyc3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [digitalocean_droplet.web.id]
}

resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = file("~/.ssh/id_rsa.pub")
}

output "loadbalancer_ip" {
    value = digitalocean_loadbalancer.public.ip
}

output "droplet_ip" {
    value = digitalocean_droplet.web.ipv4_address
}