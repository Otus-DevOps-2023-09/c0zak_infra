variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  type        = string
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  type        = string
}
variable "subnet_id" {
  description = "Subnets for modules"
  type        = string
}
variable "docker_reddit_image" {
  description = "Disk image for reddit app"
  type = string
}
variable "instances_count" {
  description = "Instances count"
  type        = number
}
