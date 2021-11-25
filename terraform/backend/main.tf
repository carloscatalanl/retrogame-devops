terraform {
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

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "virtualnet" {
  name                = "tfBeVN"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "tfBeSN"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virtualnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_storage_account" "asa" {
  name                     = var.asa_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_blob_public_access = true

  network_rules {
    default_action = "Allow"
    // ip_rules                   = ["187.158.1.252"]
    // ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.subnet.id]
  }
}

resource "azurerm_storage_container" "asc" {
  name                  = var.asc_name
  storage_account_name  = azurerm_storage_account.asa.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "vault" {
  name                  = var.asc_vault_name
  storage_account_name  = azurerm_storage_account.asa.name
  container_access_type = "blob"
}