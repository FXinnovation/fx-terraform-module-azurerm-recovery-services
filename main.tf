resource "azurerm_recovery_services_vault" "this" {
  name                = var.recovery_vault_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_recovery_services_protection_policy_vm" "this" {
  name                = "${var.recovery_vault_name}-protection-policy"
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this.name

  timezone = var.backup_timezone

  backup {
    frequency = var.backup_frequency
    time      = var.backup_time
    weekdays  = var.backup_frequency == "Weekly" ? var.backup_weekdays : []
  }

  // To be included only if backup frequency is daily
  dynamic "retention_daily" {
    for_each = var.backup_frequency == "Daily" ? [1] : []
    content {
      count = var.backup_retention_daily_count < 7 ? 7 : var.backup_retention_daily_count
    }
  }

  # To be included only if a weekly retention count is defined or if frequency is weekly
  dynamic "retention_weekly" {
    for_each = var.backup_retention_weekly_count > 0 || var.backup_frequency == "Weekly" ? [1] : []
    content {
      count    = var.backup_retention_weekly_count > 0 ? var.backup_retention_weekly_count : 12
      weekdays = var.backup_weekdays
    }
  }

  # To be included only if a monthly retention count is defined
  dynamic "retention_monthly" {
    for_each = var.backup_retention_monthly_count > 0 ? [1] : []
    content {
      count    = var.backup_retention_monthly_count
      weekdays = var.backup_retention_monthly_weekdays
      weeks    = var.backup_retention_monthly_weeks
    }
  }

  # To be included only if a yearly retention count is defined
  dynamic "retention_yearly" {
    for_each = var.backup_retention_monthly_count > 0 ? [1] : []
    content {
      count    = var.backup_retention_yearly_count
      weekdays = var.backup_retention_yearly_weekdays
      weeks    = var.backup_retention_yearly_weeks
      months   = var.backup_retention_yearly_months
    }
  }
}

resource "azurerm_recovery_services_protected_vm" "this" {
  count               = length(var.source_vm_ids)
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  source_vm_id        = var.source_vm_ids[count.index]
  backup_policy_id    = azurerm_recovery_services_protection_policy_vm.this.id
}
