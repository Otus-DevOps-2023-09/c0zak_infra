terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.keyfile_path
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "instance_setup" {
  source           = "./instance_setup"
  public_key_path  = var.public_key_path
  subnet_id        = var.subnet_id
  private_key_path = var.private_key_path
  instances_count  = var.instances_count
  docker_reddit_image = var.docker_reddit_image
}
