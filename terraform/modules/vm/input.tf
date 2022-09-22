variable resource_group {}
variable location {}
variable "application_type" {}
variable "resource_type" {}
variable "subnet_id" {}
variable "public_ip_address_id" {}

variable "username" {
  description = "The azure user name"
  default = "shohrab"
}
variable "password" {
  description = "Password for azure protal"
  default = "bangladesh_1983!"
}
