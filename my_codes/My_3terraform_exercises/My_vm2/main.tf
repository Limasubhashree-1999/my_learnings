terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.10.0"
    }
  }

  # required_version = ">= 1.1.0"
}


provider "azurerm" {
  features {}
}
data "azurerm_resource_group" "resource1" {
    name = var.rg
  
}
resource "azurerm_virtual_network" "vnet1" {
    name = var.vnet2
    location = var.location
    resource_group_name = data.azurerm_resource_group.resource1.name
    address_space = [ "10.0.0.0/16" ]
}
resource "azurerm_subnet" "subnet1" {
    name = var.subnet2
    resource_group_name = data.azurerm_resource_group.resource1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.0.2.0/24" ]
}
output "resource_group_id" {
  value = data.azurerm_resource_group.resource1.id
}

resource "azurerm_public_ip" "azpip2" {
  name                    = var.vm2_pip
  location                = data.azurerm_resource_group.resource1.location
  resource_group_name     = data.azurerm_resource_group.resource1.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "vm2"
  }
}
resource "azurerm_network_interface" "networkint2" {
  name = var.vm2_nic
  location = data.azurerm_resource_group.resource1.location
  resource_group_name = data.azurerm_resource_group.resource1.name
  ip_configuration {
    name = "testipconfig2"
    subnet_id = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "vir2" {
  name = var.vm2_name
  resource_group_name = data.azurerm_resource_group.resource1.name
  location = data.azurerm_resource_group.resource1.location
  network_interface_ids = [azurerm_network_interface.networkint2.id]
  vm_size = var.vm2_size

  

storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.username
    admin_password = var.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "vir.machine"
  }

}
