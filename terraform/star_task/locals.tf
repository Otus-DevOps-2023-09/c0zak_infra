locals {
  vm_ips = [
    for app in yandex_compute_instance.app : app.network_interface[0].ip_address
  ]
}
