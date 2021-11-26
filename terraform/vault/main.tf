terraform {
  backend "azurerm" {
    resource_group_name  = "terraformBackend"
    storage_account_name = "retrogametf"
    container_name       = "terraform-state-vault"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.80.0"
    }
  }
}

provider "azurerm" {
  features {}
}

  
  # VNET
  resource "azurerm_virtual_network" "my_virtual_network" {
    name                = "myVNetwork"
    resource_group_name = var.rg_name
    location            = var.location
    address_space       = ["10.0.0.0/16"]
  }
  
  # Subnet
  resource "azurerm_subnet" "my_subnet" {
    name                 = "internal"
    resource_group_name  = var.rg_name
    virtual_network_name = azurerm_virtual_network.my_virtual_network.name
    address_prefixes     = ["10.0.2.0/24"]
  }
  
  # Public IP
  resource "azurerm_public_ip" "my_pub_ip" {
    name                = "myPubIP"
    location            = var.location
    resource_group_name = var.rg_name
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  
  # Route Table
  resource "azurerm_route_table" "my_rt" {
    name                          = "myRT"
    location                      = var.location
    resource_group_name           = var.rg_name
    disable_bgp_route_propagation = false
  
    route {
      name                   = "route1"
      address_prefix         = "10.100.0.0/14"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.10.1.1"
    }
  }
  
  resource "azurerm_route" "my_route" {
    name                = "acceptanceTestRoute1"
    resource_group_name = var.rg_name
    route_table_name    = azurerm_route_table.my_rt.name
    address_prefix      = "10.1.0.0/16"
    next_hop_type       = "vnetlocal"
  }
  
  # Subnet Route Table Association
  resource "azurerm_subnet_route_table_association" "my_rt_asct" {
    subnet_id      = azurerm_subnet.my_subnet.id
    route_table_id = azurerm_route_table.my_rt.id
  }
  
  # Security Group
  resource "azurerm_network_security_group" "my_sg" {
    name                = "mySG"
    location            = var.location
    resource_group_name = var.rg_name
  
     security_rule {
      access                     = "Allow"
      direction                  = "Inbound"
      name                       = "ssh"
      priority                   = 200
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = "22"
      destination_address_prefix = azurerm_network_interface.main.private_ip_address
    }
    security_rule {
        access                     = "Allow"
        direction                  = "Inbound"
        name                       = "vault"
        priority                   = 300
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "8200"
        destination_address_prefix = azurerm_network_interface.main.private_ip_address
      }
  }
  
  resource "azurerm_network_interface_security_group_association" "main" {
    network_interface_id      = azurerm_network_interface.internal.id
    network_security_group_id = azurerm_network_security_group.my_sg.id
  }
  resource "azurerm_network_interface_security_group_association" "main2" {
    network_interface_id      = azurerm_network_interface.main.id
    network_security_group_id = azurerm_network_security_group.my_sg.id
  }
  
  # Net Interface
  resource "azurerm_network_interface" "main" {
    name                = "Main-NIC"
    resource_group_name = var.rg_name
    location            = var.location
    ip_configuration {
      name                          = "primary"
      subnet_id                     = azurerm_subnet.my_subnet.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.my_pub_ip.id
    }
  }
  resource "azurerm_network_interface" "internal" {
    name                      = "Internal-NIC"
    resource_group_name       = var.rg_name
    location                  = var.location
    ip_configuration {
      name                          = "internal"
      subnet_id                     = azurerm_subnet.my_subnet.id
      private_ip_address_allocation = "Dynamic"
    }
  }
  
  # Virtual Machine
  resource "azurerm_linux_virtual_machine" "my_vm" {
    name                = "vault-VM"
    resource_group_name = var.rg_name
    location            = var.location
    size                = "Standard_F2"
    admin_username      = "azureuser"
    network_interface_ids = [
      azurerm_network_interface.main.id,
      azurerm_network_interface.internal.id,
    ]
  
    admin_ssh_key {
      username   = "azureuser"
      public_key = file("./vault_rsa.pub")
    }
  
    os_disk {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
  
    source_image_reference {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }