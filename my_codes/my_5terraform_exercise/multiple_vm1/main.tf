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

resource "azurerm_resource_group" "az_resources" {
  name     = "azure-resources"
  location = "East Asia"
}

resource "azurerm_virtual_network" "az_network" {
  name                = "azure-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.az_resources.location
  resource_group_name = azurerm_resource_group.az_resources.name
}

resource "azurerm_subnet" "az_subnet" {
  name                 = "azure_subnet"
  resource_group_name  = azurerm_resource_group.az_resources.name
  virtual_network_name = azurerm_virtual_network.az_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "az_nic" {
  count               = 2
  name                = "azure-NIC-${count.index}"
  location            = azurerm_resource_group.az_resources.location
  resource_group_name = azurerm_resource_group.az_resources.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_subnet.id
    private_ip_address_allocation = "Dynamic"
    

  }
}

resource "azurerm_ssh_public_key" "az_pub_key" {
  name                = "az_pkey"
  resource_group_name = azurerm_resource_group.az_resources.name
  location            = azurerm_resource_group.az_resources.location
  public_key          = file("~/.ssh/id_rsa.pub")
}
resource "azurerm_public_ip" "az_pip" {
  count               = 2
  name                = "azure-vm-nic-0${count.index}"
  resource_group_name = azurerm_resource_group.az_resources.name
  location            = azurerm_resource_group.az_resources.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_security_group" "az_network_security" {
  name                = "azure-security-group1"
  location            = azurerm_resource_group.az_resources.location
  resource_group_name = azurerm_resource_group.az_resources.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = ["22","80"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}



resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "azure-VM-${count.index}"
  count               = 2
  resource_group_name = azurerm_resource_group.az_resources.name
  location            = azurerm_resource_group.az_resources.location
  size                = "Standard_ds1_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    element(azurerm_network_interface.az_nic.*.id, count.index)
 ]


 admin_ssh_key {
    username   = "adminuser"
    public_key = azurerm_ssh_public_key.az_pub_key.public_key
 }
  
 os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19.04"
    version   = "latest"
  }

  provisioner "file" {
    source      = "/var/www/html/subha"
    destination = "/tmp/index.html"

  connection {
    type     = "ssh"
    user     = "adminuser"
    password = "password"
    host     = azurerm_public_ip.az_pip[count.index]

   }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install apache2 -y",
      "sudo cp /tmp/index.html /var/www/html/subha",
      "sudo systemctl restart apache2",
      "sudo systemctl status apache2",
    ]
  connection {
    type     = "ssh"
    user     = "username"

    
    password = "password123"
    host     = azurerm_public_ip.az_pip[count.index]
  }

 }
}
resource "azurerm_network_interface_security_group_association" "az_association" {
    count = 2
    network_interface_id      = element(azurerm_network_interface.az_nic.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.az_network_security.id
}
output "vm_public_ip" {
<<<<<<< HEAD
  value = azurerm_public_ip.az_pip
}
=======
  value = azurerm_public_ip.az-pip
}
>>>>>>> cac7cf7903e2187e3cbc2a677aaf33a427f5038e
