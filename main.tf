locals {
  should_create_backup_container            = var.enabled && var.backup_storage_container_enabled
  should_create_backup_vm_policy            = var.enabled && var.backup_vm_policy_enabled
  should_create_backup_protected_vm         = var.enabled && var.backup_protected_vm_enabled
  should_create_backup_policy_file_share    = var.enabled && var.backup_policy_file_share_enabled
  should_create_backup_protected_file_share = var.enabled && var.backup_protected_file_share_enabled
}


###
# Recovery service vault
###

resource "azurerm_recovery_services_vault" "this" {
  count = var.enabled ? 1 : 0

  name                = var.recovery_service_vault_name
  sku                 = var.recovery_service_vault_sku
  location            = var.recovery_service_vault_location
  resource_group_name = var.resource_group_name
  soft_delete_enabled = var.recovery_service_vault_soft_delete_enabled

  tags = merge(
    var.tags,
    var.recovery_service_vault_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# Backup container storage account
###

resource "azurerm_backup_container_storage_account" "this_container" {
  count = local.should_create_backup_container ? length(var.backup_container_storage_account_ids) : 0

  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_service_vault_name
  storage_account_id  = element(var.backup_container_storage_account_ids, count.index)

  depends_on = [azurerm_recovery_services_vault.this]
}

###
# Backup policy VM
###

resource "azurerm_backup_policy_vm" "this" {
  count = local.should_create_backup_vm_policy ? var.backup_vm_policy_count : 0

  name                = element(var.backup_vm_policy_names, count.index)
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this[count.index].name

  timezone = element(var.backup_timezones, count.index)

  dynamic "backup" {
    for_each = element(var.backup_frequencies, count.index) != "" ? [1] : []

    content {
      frequency = element(var.backup_frequencies, count.index)
      time      = element(var.backup_times, count.index)
      weekdays  = element(var.backup_frequencies, count.index) == "Weekly" ? element(var.backup_weekdays, count.index) : []
    }
  }

  dynamic "retention_daily" {
    for_each = element(var.backup_frequencies, count.index) == "Daily" ? [1] : []

    content {
      count = element(var.backup_retention_daily_counts, count.index)
    }
  }

  dynamic "retention_weekly" {
    for_each = element(var.backup_retention_weekly_counts, count.index) > 0 || element(var.backup_frequencies, count.index) == "Weekly" ? [1] : []

    content {
      count    = element(var.backup_retention_weekly_counts, count.index)
      weekdays = element(var.backup_retention_weekdays, count.index)
    }
  }

  dynamic "retention_monthly" {
    for_each = element(var.backup_retention_monthly_counts, count.index) > 0 ? [1] : []

    content {
      count    = element(var.backup_retention_monthly_counts, count.index)
      weekdays = element(var.backup_retention_monthly_weekdays, count.index)
      weeks    = element(var.backup_retention_monthly_weeks, count.index)
    }
  }

  dynamic "retention_yearly" {
    for_each = element(var.backup_retention_yearly_counts, count.index) > 0 ? [1] : []

    content {
      count    = element(var.backup_retention_yearly_counts, count.index)
      weekdays = element(var.backup_retention_yearly_weekdays, count.index)
      weeks    = element(var.backup_retention_yearly_weeks, count.index)
      months   = element(var.backup_retention_yearly_months, count.index)
    }
  }
}

###
# Backup protected VM
###

resource "azurerm_backup_protected_vm" "this_vm" {
  count = local.should_create_backup_protected_vm ? length(var.backup_protected_source_vm_ids) : 0

  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_service_vault_name
  source_vm_id        = element(var.backup_protected_source_vm_ids, count.index)
  backup_policy_id    = element(compact(concat(concat(azurerm_backup_policy_vm.this.*.id, [""]), var.existing_backup_vm_policy_ids)), count.index)
}

###
# Backup policy file share
###

resource "azurerm_backup_policy_file_share" "this" {
  count = local.should_create_backup_policy_file_share ? var.backup_policy_file_share_count : 0

  name                = element(var.backup_policy_file_share_names, count.index)
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this[count.index].name
  timezone            = element(var.backup_policy_file_share_timezones, count.index)

  dynamic "backup" {
    for_each = element(var.backup_policy_file_share_frequencies, count.index) != "" ? [1] : []

    content {
      frequency = element(var.backup_policy_file_share_frequencies, count.index)
      time      = element(var.backup_policy_file_share_times, count.index)
    }
  }

  dynamic "retention_daily" {
    for_each = element(var.backup_policy_file_share_frequencies, count.index) == "Daily" ? [1] : []

    content {
      count = element(var.backup_policy_file_share_daily_retention_counts, count.index)
    }
  }

}

###
# Backup protected file share
###

resource "azurerm_backup_protected_file_share" "this" {
  count = local.should_create_backup_protected_file_share ? length(var.backup_protected_file_share_source_file_share_names) : 0

  resource_group_name       = var.resource_group_name
  recovery_vault_name       = azurerm_recovery_services_vault.this[count.index].name
  source_storage_account_id = element(azurerm_backup_container_storage_account.this_container.*.storage_account_id, count.index)
  source_file_share_name    = element(var.backup_protected_file_share_source_file_share_names, count.index)
  backup_policy_id          = element(compact(concat(concat(azurerm_backup_policy_file_share.this.*.id, [""]), var.existing_backup_file_share_policy_ids)), count.index)
}
