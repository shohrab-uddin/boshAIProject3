resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "${var.username}"
  // admin_password      = "${var.password}"
  disable_password_authentication  = true
  network_interface_ids = [
	azurerm_network_interface.test.id,
	]
  admin_ssh_key {
    username   = "${var.username}"
    public_key = "${var.ssh_public_key}"
    // public_key = file("~/.ssh/id_rsa.pub")  // this is required when running terraform plan or apply in Azure cloud shell
    // public_key = file("C:/Users/shohr/.ssh/id_rsa_azure_portal.pub") // this is required when running terraform plan or apply in local machine
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
