variable "cloud_id" {
  description = "Cloud"
  type = string
}
variable "folder_id" {
  description = "Folder"
  type = string
}
variable "zone" {
  description = "Zone"
  type = string
}
variable "subnet_id" {
  description = "Subnet"
  type = string
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  type = string
}
variable "private_key_path" {
  # Описание переменной
  description = "Path to the private key used for ssh access"
  type = string
}
variable "keyfile_path" {
  # Описание переменной
  description = "Path to the API key file"
  type = string
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
  type = string
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
  type = string
}
variable "need_deploy" {
  description = "Need to deploy app"
  type        = bool
}
