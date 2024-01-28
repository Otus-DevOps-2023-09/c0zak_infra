terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
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

module "vm" {
  source        = "./modules/vm"
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
  image_id = var.image_id
}
