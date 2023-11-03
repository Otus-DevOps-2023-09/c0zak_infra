resource "yandex_lb_network_load_balancer" "reddit-balancer" {
  name                = "reddit-balancer"
  deletion_protection = false
  listener {
    name = "worker"
    port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit-group.id
    healthcheck {
      name = "check"
      http_options {
        port = 9292
      }
    }
  }
}
