variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  type = string
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  type = string
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
  type = string
}
variable "subnet_id" {
  description = "Subnets for modules"
  type = string
}
variable "database_address" {
  description = "Database IP"
  type = string
}
variable "need_deploy" {
  description = "Need to deploy app"
  type        = bool
}
variable "instance_type" {
  description = "Prod/Stage"
  type        = string
}
