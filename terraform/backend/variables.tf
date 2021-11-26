variable "location" {
  type        = string
  description = "Variable to set the location for the resource group"
}
variable "rg_name" {
  type        = string
  description = "Variable to set the resource group name"
}
variable "asa_name" {
  type        = string
  description = "Variable to set the Azure Storage Account name"
}
variable "asc_name" {
  type        = string
  description = "Variable to set the Azure Storage Container name"
}

variable "asc_vault_name" {
  type        = string
  description = "Variable to set the Azure Storage Container Vault name"
}

variable "asc_test_name" {
  type        = string
  description = "Variable to set the Azure Storage Container Test name"
}

