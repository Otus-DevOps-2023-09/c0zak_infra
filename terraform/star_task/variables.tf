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
variable "instances_count" {
  description = "Default count of instances"
  type        = number
  default     = 1
}
