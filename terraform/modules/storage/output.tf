output "storage_account_name" {
  value = "${azurerm_storage_account.storage.name}"
}

output "storage_container_name" {
  value = "${azurerm_storage_container.container.name}"
}

output "storage_account_access_key" {
  value = "${azurerm_storage_account.storage.primary_access_key}"
}

