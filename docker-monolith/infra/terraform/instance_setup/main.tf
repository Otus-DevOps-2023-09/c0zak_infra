terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0"
    }
  }
  required_version = ">= 0.13"
}


resource "yandex_compute_instance" "docker_reddit" {
  name = format("docker-reddit-%d", count.index)
  labels = {
    tag  = "docker-reddit"
  }

  count = var.instances_count

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.docker_reddit_image
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
}
