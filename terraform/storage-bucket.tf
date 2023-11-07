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

module "storage" {
  source             = "./modules/storage"
  reddit-bucket      = var.reddit-bucket
  service_account_id = var.service_account_id
}
