output "external_ip_address_balancer" {
  value = yandex_lb_network_load_balancer.reddit-balancer.listener
}
