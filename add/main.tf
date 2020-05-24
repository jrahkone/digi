variable "rg" {}
variable "loc" {default="westeurope"}
variable "admin_username" {default="azureuser"}

provider "azurerm" {
  features {}
  version = "=2.0.0"
}

resource "azurerm_public_ip" "ip" {
  count = 1
  name                = "ip${count.index}"
  location            = var.loc
  resource_group_name = var.rg
  allocation_method   = "Static"
}

output "ip0" { value = azurerm_public_ip.ip[0].ip_address }
