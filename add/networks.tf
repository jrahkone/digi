# start networks

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.loc
  resource_group_name = var.rg
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.1.0/24"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = var.loc
  resource_group_name = var.rg

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface nic
resource "azurerm_network_interface" "nic" {
  count = 1
  name                      = "nic${count.index}"
  location                  = var.loc
  resource_group_name       = var.rg
  ip_configuration {
    name                          = "nic${count.index}_conf"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
	public_ip_address_id          = azurerm_public_ip.ip[0].id
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic[0].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# end networks
