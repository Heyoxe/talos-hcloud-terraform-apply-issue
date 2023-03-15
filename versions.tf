terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.36.2"
    }

    talos = {
      source  = "siderolabs/talos"
      version = "0.1.2"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}
