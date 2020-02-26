resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "Canada Central"
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "tf${random_string.this.result}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  vm_size               = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.vm.id]

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name              = "vm-os-disk"
    os_type           = "Linux"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    admin_username = "test-admin-123"
    admin_password = "test-pwd-123"
    computer_name  = "vm"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


module "example" {
  source = "../.."

  resource_group_name             = "tftest${random_string.this.result}"
  recovery_service_vault_name     = "test${random_string.this.result}"
  recovery_service_vault_location = "Canada Central"
  recovery_service_vault_sku      = "Standard"

  backup_vm_policy_enabled          = true
  backup_frequency                  = ["Daily"]
  backup_time                       = ["23:00"]
  backup_timezone                   = ["America/Toronto"]
  backup_retention_daily_count      = [31]
  backup_retention_weekly_count     = [5]
  backup_retention_weekdays         = [["Sunday"]]
  backup_retention_monthly_count    = [12]
  backup_retention_monthly_weekdays = [["Sunday"]]
  backup_retention_monthly_weeks    = [["First"]]
  backup_retention_yearly_count     = [7]
  backup_retention_yearly_weekdays  = [["Sunday"]]
  backup_retention_yearly_weeks     = [["First"]]
  backup_retention_yearly_months    = [["January"]]
}
