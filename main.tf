data "hcloud_image" "talos_image" {
  with_selector = "os=talos,type=infra"
  most_recent   = true
}
