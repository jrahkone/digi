# start vm
# Create a Linux virtual machine
resource "azurerm_linux_virtual_machine" "vm1" {
  name                  = "vm1"
  resource_group_name   = var.rg
  location              = var.loc
  size                  = "Standard_F2s_v2"
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic[0].id]
  
  admin_ssh_key {
	username = var.admin_username
	public_key = file("~/.ssh/id_rsa.pub")
  }

  # ephemeral os disk - it will automatically get deleted with vm
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadOnly"
	diff_disk_settings {
	  option = "Local"
    }
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  provisioner "file" {
	connection {
	  host     = self.public_ip_address
	  user     = var.admin_username
	  private_key = file("~/.ssh/id_rsa")
	  #type = "ssh"
	  #password = var.admin_password
	}	
	source      = "install-vm-stuff.sh"
	destination = "install.sh"
  }
  
  provisioner "remote-exec" {
	connection {
	  host     = self.public_ip_address
	  user     = var.admin_username
	  private_key = file("~/.ssh/id_rsa")
	  #type = "ssh"
	  #password = var.admin_password
	}
	inline = [
	  "chmod u+x install.sh",
	  "./install.sh"
	]
  }
}

# end vm
