resource "yandex_lb_target_group" "reddit-group" {
  name = "reddit-group"
  dynamic "target" {
    for_each = local.vm_ips
    content {
      subnet_id = var.subnet_id
      address   = target.value
    }
  }
}
