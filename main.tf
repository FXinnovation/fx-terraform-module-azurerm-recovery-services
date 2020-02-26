locals {
  should_create_backup_container            = var.enabled && var.backup_storage_container_enabled
  should_create_backup_vm_policy            = var.enabled && var.backup_vm_policy_enabled
  should_create_backup_protected_vm         = var.enabled && var.backup_protected_vm_enabled
  should_create_backup_policy_file_share    = var.enabled && var.backup_policy_file_share_enabled
  should_create_backup_protected_file_share = var.enabled && var.backup_protected_file_share_enabled
  backup_policy_ids                         = zipmap(var.backup_vm_policy_names, compact(concat(azurerm_backup_policy_vm.this.*.id, [""])))
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
}

###
# Backup policy VM
###

resource "azurerm_backup_policy_vm" "this" {
  count = local.should_create_backup_vm_policy ? var.backup_vm_policy_count : 0

  name                = element(var.backup_vm_policy_names, count.index)
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_service_vault_name

  timezone = element(var.backup_timezone, count.index)

  dynamic "backup" {
    for_each = var.backup_frequency[count.index] != "" ? [1] : []

    content {
      frequency = element(var.backup_frequency, count.index)
      time      = element(var.backup_time, count.index)
      weekdays  = element(var.backup_frequency, count.index) == "Weekly" ? element(var.backup_weekdays, count.index) : ""
    }
  }

  dynamic "retention_daily" {
    for_each = var.backup_frequency[count.index] == "Daily" ? [1] : []

    content {
      count = element(var.backup_retention_daily_count, count.index)
    }
  }

  dynamic "retention_weekly" {
    for_each = var.backup_retention_weekly_count[count.index] > 0 || element(var.backup_frequency, count.index) == "Weekly" ? [1] : []

    content {
      count    = element(var.backup_retention_weekly_count, count.index)
      weekdays = element(var.backup_rentntion_weekdays, count.index)
    }
  }

  dynamic "retention_monthly" {
    for_each = var.backup_retention_monthly_count[count.index] > 0 ? [1] : []

    content {
      count    = element(var.backup_retention_monthly_count, count.index)
      weekdays = element(var.backup_retention_monthly_weekdays, count.index)
      weeks    = element(var.backup_retention_monthly_weeks, count.index)
    }
  }

  dynamic "retention_yearly" {
    for_each = var.backup_retention_yearly_count[count.index] > 0 ? [1] : []

    content {
      count    = element(var.backup_retention_yearly_count, count.index)
      weekdays = element(var.backup_retention_yearly_weekdays, count.index)
      weeks    = element(var.backup_retention_yearly_weeks, count.index)
      months   = element(var.backup_retention_yearly_months, count.index)
    }
  }

  tags = merge(
    var.tags,
    var.backup_policy_vm_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# Backup protected VM
###

resource "azurerm_backup_protected_vm" "this_vm" {
  count = local.should_create_backup_protected_vm ? length(var.backup_protected_source_vm_ids) : 0

  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_service_vault_name
  source_vm_id        = element(var.backup_protected_source_vm_ids, count.index)
  backup_policy_id    = var.backup_vm_policy_enabled ? lookup(local.backup_policy_ids, element(var.backup_vm_policy_id_names, count.index), null) : element(var.existing_backup_policy_id, count.index)

  tags = merge(
    var.tags,
    var.backup_protected_vm_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# Backup policy file share
###

resource "azurerm_backup_policy_file_share" "this" {
  count = local.should_create_backup_policy_file_share ? var.backup_policy_file_share_count : 0

  name                = element(var.backup_policy_file_share_names, count.index)
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_service_vault_name
  timezone            = element(var.backup_policy_file_share_timezones, count.index)

  dynamic "backup" {
    for_each = var.backup_policy_file_share_frequencies[count.index] != "" ? [1] : []

    content {
      frequency = element(var.backup_policy_file_share_frequencies, count.index)
      time      = element(var.backup_policy_file_share_times, count.index)
    }
  }

  dynamic "retention_daily" {
    for_each = var.backup_policy_file_share_frequencies[count.index] == "Daily" ? [1] : []

    content {
      count = element(var.backup_policy_file_share_daily_retention_count, count.index)
    }
  }

}

###
# Backup protected file share
###

resource "azurerm_backup_protected_file_share" "this" {
  count = local.should_create_backup_protected_file_share ? length(var.backup_protected_file_share_source_file_share_names) : 0

  resource_group_name       = var.resource_group_name
  recovery_vault_name       = var.recovery_service_vault_name
  source_storage_account_id = element(var.backup_protected_file_share_source_storage_account_ids, count.index)
  source_file_share_name    = element(var.backup_protected_file_share_source_file_share_names, count.index)
  backup_policy_id          = var.backup_policy_file_share_enabled ? element(azurerm_backup_policy_file_share.this.*.id, count.index) : element(var.existing_backup_file_share_policy_ids, count.index)
}
