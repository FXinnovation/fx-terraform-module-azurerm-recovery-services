resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "Canada Central"
}

resource "azurerm_storage_account" "example" {
  name                     = "tftest${random_string.this.result}"
  location                 = "${azurerm_resource_group.example.location}"
  resource_group_name      = "${azurerm_resource_group.example.name}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "example" {
  name                 = "tftest${random_string.this.result}"
  storage_account_name = "${azurerm_storage_account.example.name}"
  metadata             = {}

  lifecycle {
    ignore_changes = [
      metadata,
    ]
  }
}

module "example" {
  source = "../.."

  resource_group_name                        = "${azurerm_resource_group.example.name}"
  recovery_service_vault_name                = "tftest${random_string.this.result}"
  recovery_service_vault_location            = "${azurerm_resource_group.example.location}"
  recovery_service_vault_sku                 = "Standard"
  recovery_service_vault_soft_delete_enabled = false

  backup_policy_file_share_enabled                = true
  backup_policy_file_share_count                  = 1
  backup_policy_file_share_names                  = ["tf${random_string.this.result}"]
  backup_policy_file_share_frequencies            = ["Daily"]
  backup_policy_file_share_times                  = ["09:30"]
  backup_policy_file_share_daily_retention_counts = [12]
  backup_policy_file_share_timezones              = ["UTC"]

  backup_storage_container_enabled     = true
  backup_container_storage_account_ids = ["${azurerm_storage_account.example.id}"]

  backup_protected_file_share_enabled                 = true
  backup_protected_file_share_source_file_share_names = ["${azurerm_storage_share.example.name}"]
}
