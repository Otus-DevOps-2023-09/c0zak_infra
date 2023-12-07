variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  type = string
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  type = string
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
  type = string
}
variable "subnet_id" {
  description = "Subnets for modules"
  type = string
}
variable "instance_type" {
  description = "Prod/Stage"
  type        = string
}
