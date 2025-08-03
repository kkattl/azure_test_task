resource "azurerm_public_ip" "vm1_public_ip" {
  name                = "${var.prefix}-vm1-pub_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = var.ip_allocation_method
  sku                 = var.ip_sku
}

resource "azurerm_network_interface" "nic_vm1" {
  name                = "${var.prefix}-nic-vm1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipcfg"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.vm1_public_ip.id
  }
}

resource "azurerm_network_interface" "nic_vm2" {
  name                = "${var.prefix}-nic-vm2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipcfg"
    subnet_id                     = azurerm_subnet.private_subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

resource "azurerm_network_interface_security_group_association" "vm1_assoc" {
  network_interface_id      = azurerm_network_interface.nic_vm1.id
  network_security_group_id = azurerm_network_security_group.nsg_vm1.id
}

resource "azurerm_network_interface_security_group_association" "vm2_assoc" {
  network_interface_id      = azurerm_network_interface.nic_vm2.id
  network_security_group_id = azurerm_network_security_group.nsg_vm2.id
} 

resource "azurerm_linux_virtual_machine" "vm1" {
  name                  = "${var.prefix}-vm1-main"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic_vm1.id]

  os_disk {
    caching              = var.vm_os_disk_caching
    storage_account_type = var.vm_os_disk_storage_account_type
  }

  admin_username                  = var.admin_username
  disable_password_authentication = true

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_vm1_public_key_path) 
  }
}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                  = "${var.prefix}-vm2-db"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic_vm2.id]

  os_disk {
    caching              = var.vm_os_disk_caching
    storage_account_type = var.vm_os_disk_storage_account_type
  }

  admin_username        = var.admin_username
  disable_password_authentication = true

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_vm2_public_key_path)
  }
}
