variable "cloud_id" {
  description = "Cloud"
  type        = string
}
variable "folder_id" {
  description = "Folder"
  type        = string
}
variable "zone" {
  description = "Zone"
  type        = string
}
variable "subnet_id" {
  description = "Subnet"
  type        = string
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  type        = string
}
variable "private_key_path" {
  # Описание переменной
  description = "Path to the private key used for ssh access"
  type        = string
}
variable "keyfile_path" {
  # Описание переменной
  description = "Path to the API key file"
  type        = string
}
variable "instances_count" {
  description = "Instances count"
  type        = number
}
variable "docker_reddit_image" {
  description = "Disk image for reddit app"
  type = string
}
