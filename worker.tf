resource "talos_machine_configuration_worker" "worker" {
  cluster_name     = talos_client_configuration.talosconfig.cluster_name
  cluster_endpoint = "https://cluster.local:6443"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "hcloud_server" "worker" {
  name        = "worker"
  server_type = "cx21"
  image       = data.hcloud_image.talos_image.id
  ssh_keys    = ["admin"]
}

resource "talos_machine_configuration_apply" "worker" {
  talos_config          = talos_client_configuration.talosconfig.talos_config
  machine_configuration = talos_machine_configuration_worker.worker.machine_config
  node                  = hcloud_server.worker.ipv4_address
  endpoint              = hcloud_server.control_plane.ipv4_address

  depends_on = [
    talos_machine_configuration_apply.control_plane
  ]
}
