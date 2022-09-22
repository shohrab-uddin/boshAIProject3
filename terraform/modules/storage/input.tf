variable resource_group {}
variable location {}
variable "application_type" {}
variable "storage_account_name" {}
variable "storage_container_name" {}
variable "resource_type" {
  description = "Type of resource"
  default = "storageAccount"
}