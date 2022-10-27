terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.21.1"
    }
  }
}

provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "tfstate17745"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "8Nydb7yJ+U/borke3LU14Wg3YdxNnIOX2yyKBQm3Fhf3TnKbTHg+Ef/8btnPewb6u15pfVgK0orn+ASt/xByqQ=="
  }
}


# Locate the existing resource group
# The resource group name should be the same as the storage account that is used in terraform backend block above
data "azurerm_resource_group" "main" {
  name = "Azuredevops"
}

# If new resource group is created and used in the subsequent resources (VM, appservice, NSG etc.) terraform will first try to delete the resource group assiciated with
# storage account that is used in erraform backend block above. 
/*module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}*/

/*resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group}"
  location = var.location
}*/

module "network" {
  source               = "./modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "p3Network"
  resource_group       = data.azurerm_resource_group.main.name //module.resource_group.resource_group_name resource_group_name is the output varible name in resource_group/output.tf file
  address_prefix_test  = "${var.address_prefix_test}"
}

module "nsg-test" {
  source                = "./modules/networksecuritygroup"
  location              = "${var.location}"
  application_type      = "${var.application_type}"
  resource_type         = "NSG"
  resource_group        = data.azurerm_resource_group.main.name //resource_group_name is the output varible name in resource_group/output.tf file
  subnet_id             = "${module.network.subnet_id_test}"
  address_prefix_test   = "${var.address_prefix_test}"
}
module "appservice" {
  source                 = "./modules/appservice"
  location               = "${var.location}"
  application_type       = "${var.application_type}"
  resource_type          = "p3Appservice"
  resource_group         = data.azurerm_resource_group.main.name //resource_group_name is the output varible name in resource_group/output.tf file
}
module "publicip" {
  source                 = "./modules/publicip"
  location               = "${var.location}"
  application_type       = "${var.application_type}"
  resource_type          = "p3Publicip"
  resource_group         = data.azurerm_resource_group.main.name //resource_group_name is the output varible name in resource_group/output.tf file
}

module "virtual-machine" {
  source                 = "./modules/vm"
  application_type       = "${var.application_type}"
  resource_group         = data.azurerm_resource_group.main.name //resource_group_name is the output varible name in resource_group/output.tf file
  resource_type          = "p3vm"
  location               = "${var.location}"
  subnet_id              = "${module.network.subnet_id_test}"
  public_ip_address_id   = "${module.publicip.public_ip_address_id}"
  ssh_public_key         = "${var.ssh_public_key}"
}

/*
module "storage" {
  source               = "./modules/storage"
  location             = "${var.location}"
  application_type     = "${var.application_type}"
  resource_group       = module.resource_group.resource_group_name //resource_group_name is the output varible name in resource_group/output.tf file
  storage_account_name = "mystorage2"
  storage_container_name = "mycontainer2"
}*/