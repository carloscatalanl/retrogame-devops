variable "location" {
    type = string
    description = "Variable to set the location for the resource group"
}
variable "rg_name" {
    type = string
    description = "Variable to set the resource group name"
}
variable "cr_name" {
    type = string
    description = "Variable to set the container registry name"
}
variable "kc_name" {
    type = string
    description = "Variable to set the Kubernetes cluster name"
}