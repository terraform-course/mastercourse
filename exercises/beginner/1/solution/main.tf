resource "digitalocean_droplet" "web" {
  image  = "ubuntu-18-04-x64"
  name   = var.droplet_name
  region = "nyc3"
  size   = var.droplet_size
}

variable "droplet_size" {
    default = "s-1vcpu-1gb"
}

variable "droplet_name" {}