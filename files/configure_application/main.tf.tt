terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.HCLOUD_TOKEN
}

resource "hcloud_ssh_key" "ssh_personal_public_key" {
  name = "ssh-personal-public-key"
  public_key = var.SSH_PERSONAL_PUBLIC_KEY
}

resource "hcloud_ssh_key" "ssh_github_public_key" {
  name = "ssh-github-public-key"
  public_key = var.SSH_GITHUB_PUBLIC_KEY
}

resource "hcloud_server" "rails_web" {
  name = "rails-web"
  server_type = "cpx21"
  image = "ubuntu-24.04"
  location = "nbg1"
  ssh_keys = [
    hcloud_ssh_key.ssh_personal_public_key.id,
    hcloud_ssh_key.ssh_github_public_key.id
  ]
  user_data = templatefile(
    ".cloud/cloud_config_app.yml", {
      SSH_USER_NAME = var.SSH_USER_NAME
      SSH_PERSONAL_PUBLIC_KEY = var.SSH_PERSONAL_PUBLIC_KEY
      SSH_GITHUB_PUBLIC_KEY = var.SSH_GITHUB_PUBLIC_KEY
    }
  )
}

resource "hcloud_server" "postgres" {
  name = "postgres"
  server_type = "cpx11"
  image = "ubuntu-24.04"
  location = "nbg1"
  depends_on = [
    hcloud_server.rails_web
  ]
  ssh_keys = [
    hcloud_ssh_key.ssh_personal_public_key.id,
    hcloud_ssh_key.ssh_github_public_key.id
  ]
  user_data = templatefile(
    ".cloud/cloud_config_postgres.yml", {
      SSH_USER_NAME = var.SSH_USER_NAME
      SSH_PERSONAL_PUBLIC_KEY = var.SSH_PERSONAL_PUBLIC_KEY
      SSH_GITHUB_PUBLIC_KEY = var.SSH_GITHUB_PUBLIC_KEY
      IP_ADDRESS_WEB = hcloud_server.rails_web.ipv4_address
    }
  )
}

variable "HCLOUD_TOKEN" {
  description = "API token for Hetzner Cloud."
  type = string
}

variable "SSH_USER_NAME" {
  description = "SSH user name."
  type = string
}

variable "SSH_PERSONAL_PUBLIC_KEY" {
  description = "Personal SSH public key."
  type = string
}

variable "SSH_GITHUB_PUBLIC_KEY" {
  description = "SSH public key for GitHub Action Runner."
  type = string
}

output "ip_address_web" {
  value = hcloud_server.rails_web.ipv4_address
  description = "Public IP address of Hetzner server for Rails application."
}

output "ip_address_postgres" {
  value = hcloud_server.postgres.ipv4_address
  description = "Public IP address of Hetzner server for Postgres."
}
