resource "talos_machine_configuration_controlplane" "control_plane" {
  cluster_name     = talos_client_configuration.talosconfig.cluster_name
  cluster_endpoint = "https://cluster.local:6443"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "hcloud_server" "control_plane" {
  name        = "control-plane"
  server_type = "cx21"
  image       = data.hcloud_image.talos_image.id
  ssh_keys    = ["admin"]
}

resource "talos_machine_configuration_apply" "control_plane" {
  talos_config          = talos_client_configuration.talosconfig.talos_config
  machine_configuration = talos_machine_configuration_controlplane.control_plane.machine_config
  node                  = hcloud_server.control_plane.ipv4_address
  endpoint              = hcloud_server.control_plane.ipv4_address
}
