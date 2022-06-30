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
resource "azurerm_resource_group" "resource1" {
    name = var.rg
    location = var.location
  
}
resource "azurerm_virtual_network" "vnet1" {
    name = var.vnet
    location = var.location
    resource_group_name = azurerm_resource_group.resource1.name
    address_space = [ "10.0.0.0/16" ]
}
resource "azurerm_subnet" "subnet1" {
    name = var.subnet
    resource_group_name = azurerm_resource_group.resource1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.0.2.0/24" ]
}
resource "azurerm_public_ip" "azpip1" {
  name                    = var.vm1_pip
  location                = azurerm_resource_group.resource1.location
  resource_group_name     = azurerm_resource_group.resource1.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "vm"
  }
}
resource "azurerm_network_interface" "networkint1" {
  name = var.vm1_nic
  location = azurerm_resource_group.resource1.location
  resource_group_name = azurerm_resource_group.resource1.name
  ip_configuration {
    name = "testipconfig1"
    subnet_id = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "vir1" {
  name = var.vm1_name
  resource_group_name = azurerm_resource_group.resource1.name
  location = azurerm_resource_group.resource1.location
  network_interface_ids = [azurerm_network_interface.networkint1.id]
  vm_size = var.vm1_size

  

storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
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
