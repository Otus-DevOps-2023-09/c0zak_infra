variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  type = string
  default = "~/.ssh/appuser.pub"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  type = string
  default = "~/.ssh/appuser"
}
variable "app_disk_image" {
  description = "Disk image"
  default     = "k8s"
  type = string
}
variable "subnet_id" {
  description = "Subnets for modules"
  type = string
}
variable "image_id" {
  description = "Image ID"
  type        = string
}
