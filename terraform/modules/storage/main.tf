# terraform {
#   required_providers {
#     yandex = {
#       source = "yandex-cloud/yandex"
#     }
#   }
#   required_version = ">= 0.13"
# }

resource "yandex_iam_service_account_static_access_key" "SA-ID" {
  service_account_id = var.service_account_id
}

resource "yandex_storage_bucket" "reddit-bucket" {
  bucket        = var.reddit-bucket
  access_key    = yandex_iam_service_account_static_access_key.SA-ID.access_key
  secret_key    = yandex_iam_service_account_static_access_key.SA-ID.secret_key
  force_destroy = false
}
