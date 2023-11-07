variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
}
variable "resource_zone" {
  description = "Resource zone"
  default     = "ru-central1-a"
}
variable "image_id" {
  description = "Image"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "private_key_path" {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}
variable "keyfile_path" {
  # Описание переменной
  description = "Path to the API key file"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable "service_account_id" {
  description = "Service account ID"
}
variable "reddit-bucket" {
  description = "Bucket for save states"
}
variable "need_deploy" {
  description = "Need to deploy app"
  type = bool
}
