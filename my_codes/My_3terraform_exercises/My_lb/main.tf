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
  name     = var.rg
  location = var.location
}

resource "azurerm_public_ip" "publicip1" {
  name                = "PublicIP"
  location            = azurerm_resource_group.resource1.location
  resource_group_name = azurerm_resource_group.resource1.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "az_lb" {
  name                = "var.az_lb"
  location            = azurerm_resource_group.resource1.location
  resource_group_name = azurerm_resource_group.resource1.name

  frontend_ip_configuration {
    name                 = "my_frontip"
    public_ip_address_id = azurerm_public_ip.publicip1.id
  }
}
resource "azurerm_lb_backend_address_pool" "lbbackend" {
  loadbalancer_id = data.azurerm_lb.az_lb.id
  name            = "var.az_lb_backendpool"
}
resource "azurerm_virtual_network" "vnet1" {
    name = "var.vnet-network"
    address_space = [ "10.0.0.0/16" ]
    location = azurerm_resource_group.resource1.location
    resource_group_name = azurerm_resource_group.resource1.name

}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_network
  resource_group_name = azurerm_resource_group.resource1.name
  location = azurerm_resource_group.resource1.location
  address_space = [ "10.0.0.0/16" ]
}
data "azurerm_lb" "az_lb" {
    name = var.az_lb
    resource_group_name = azurerm_resource_group.resource1.name
  
}



data"azurerm_lb_backend_address_pool" "azlbaddress" {
  name            = var.az_lb_backend
  loadbalancer_id = data.azurerm_lb.az_lb.id
}

resource "azurerm_lb_backend_address_pool_address" "azbackpool" {
  name                    = var.az_lb_backend
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.azlbaddress.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = "10.0.0.1"
}
resource "azurerm_lb_nat_pool" "aznatpool" {
  resource_group_name            = azurerm_resource_group.resource1.name
  loadbalancer_id                = data.azurerm_lb.az_lb.id
  name                           = var.az_natpool
  protocol                       = "Tcp"
  frontend_port_start            = 80
  frontend_port_end              = 80
  backend_port                   = 8080
  frontend_ip_configuration_name = "my_frontip"
}
resource "azurerm_lb_nat_rule" "aznat" {
  resource_group_name            = azurerm_resource_group.resource1.name
  loadbalancer_id                = data.azurerm_lb.az_lb.id
  name                           = var.az_natrule
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "my_frontip"
}
resource "azurerm_lb_outbound_rule" "azoutbound" {
  loadbalancer_id         = azurerm_lb.az_lb.id
  name                    = var.az_outbound
  protocol                = "Tcp"
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.azlbaddress.id

  frontend_ip_configuration {
    name = "my_frontip"
  }
}
resource "azurerm_lb_probe" "azlbprobe" {
  loadbalancer_id = data.azurerm_lb.az_lb.id
  name            = var.az_lb_probe
  port            = 22
}
resource "azurerm_lb_rule" "azlbrule" {
  loadbalancer_id                = data.azurerm_lb.az_lb.id
  name                           = var.az_lb_rule
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "my_frontip"
}

resource "azurerm_virtual_network" "virnet1" {
    name = var.vnet
    location = var.location
    resource_group_name = azurerm_resource_group.resource1.name
    address_space = [ "10.0.0.0/16" ]
}
resource "azurerm_subnet" "subnet1" {
    name = var.subnet
    resource_group_name = azurerm_resource_group.resource1.name
    virtual_network_name = azurerm_virtual_network.virnet1.name
    address_prefixes = [ "10.0.2.0/24" ]
}
resource "azurerm_public_ip" "azpip1" {
  name                    = var.az_pip
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

resource "azurerm_virtual_network" "vnet2" {
    name = var.vnet
    location = var.location
    resource_group_name = azurerm_resource_group.resource1.name
    address_space = [ "10.0.0.0/16" ]
}
resource "azurerm_subnet" "subnet2" {
    name = var.subnet2
    resource_group_name = azurerm_resource_group.resource1.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    address_prefixes = [ "10.0.2.0/24" ]
}
output "resource_group_id" {
  value = azurerm_resource_group.resource1.id
}

resource "azurerm_public_ip" "azpip2" {
  name                    = var.az_pip2
  location                = azurerm_resource_group.resource1.location
  resource_group_name     = azurerm_resource_group.resource1.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "vm2"
  }
}
resource "azurerm_network_interface" "networkint2" {
  name = var.vm2_nic
  location = azurerm_resource_group.resource1.location
  resource_group_name = azurerm_resource_group.resource1.name
  ip_configuration {
    name = "testipconfig2"
    subnet_id = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "vir2" {
  name = var.vm2_name
  resource_group_name = azurerm_resource_group.resource1.name
  location = azurerm_resource_group.resource1.location
  network_interface_ids = [azurerm_network_interface.networkint2.id]
  vm_size = var.vm1_size

  

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
    environment = "vir.machine2"
  }

}
