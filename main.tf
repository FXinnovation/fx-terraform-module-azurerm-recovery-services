###
# Recovery service vault
###

resource "azurerm_recovery_services_vault" "this" {
  count = var.enabled ? 1 : 0

  name                = var.recovery_service_vault_names
  location            = var.recovery_service_vault_locations
  resource_group_name = var.resource_group_name
  sku                 = var.recovery_service_vault_skus
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
# Recovery network mapping
###

resource "azurerm_recovery_network_mapping" "this" {
  count = var.enabled ? 1 : 0

  name                        = var.recovery_network_mapping_names
  resource_group_name         = var.resource_group_name
  recovery_vault_name         = element(azurerm_recovery_service_vault.this.*.id, count.index)
  source_recovery_fabric_name = var.source_recovery_fabric_names
  target_recovery_fabric_name = var.target_recovery_fabric_names
  source_network_id           = var.source_network_ids
  target_network_id           = var.target_network_ids
}

###
# Recovery service protection policy VM
###

resource "azurerm_recovery_services_protection_policy_vm" "this" {
  count = var.enabled ? 1 : 0

  name                = var.recovery_service_protection_policy_vm_names
  resource_group_name = var.resource_group_name
  recovery_vault_name = element(azurerm_recovery_service_vault.this.*.id, count.index)

  timezone = var.backup_timezone

  dynamic "backup" {
    for_each = var.backup_frequency != "" ? [1] : []

    content {
      frequency = var.backup_frequency
      time      = var.backup_time
      weekdays  = var.backup_frequency == "Weekly" ? var.backup_weekdays : []
    }
  }

  dynamic "retention_daily" {
    for_each = var.backup_frequency == "Daily" ? [1] : []

    content {
      count = var.backup_retention_daily_count
    }
  }

  dynamic "retention_weekly" {
    for_each = var.backup_retention_weekly_count > 0 || var.backup_frequency == "Weekly" ? [1] : []

    content {
      count    = var.backup_retention_weekly_count
      weekdays = var.backup_rentntion_weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = var.backup_retention_monthly_count > 0 ? [1] : []

    content {
      count    = var.backup_retention_monthly_count
      weekdays = var.backup_retention_monthly_weekdays
      weeks    = var.backup_retention_monthly_weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = var.backup_retention_yearly_count > 0 ? [1] : []

    content {
      count    = var.backup_retention_yearly_count
      weekdays = var.backup_retention_yearly_weekdays
      weeks    = var.backup_retention_yearly_weeks
      months   = var.backup_retention_yearly_months
    }
  }

  tags = merge(
    var.tags,
    var.recovery_service_protection_policy_vm_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# Recovery service protected VM
###

resource "azurerm_recovery_services_protected_vm" "this_vm" {
  count = length(var.source_vm_ids)

  resource_group_name = var.resource_group_name
  recovery_vault_name = element(azurerm_recovery_service_vault.this.*.id, count.index)
  source_vm_id        = var.recovery_service_protected_source_vm_ids[count.index]
  backup_policy_id    = element(azurerm_recovery_services_protection_policy_vm.this.*.id, count.index)
}

###
# Recovery service replication policy
###

resource "azurerm_recovery_services_replication_policy" "this_policy" {
  count = var.enabled ? 1 : 0

  name                                                 = var.recovery_service_replication_policy_names
  resource_group_name                                  = var.resource_group_name
  recovery_vault_name                                  = element(azurerm_recovery_service_vault.this.*.id, count.index)
  recovery_point_retention_in_minnutes                 = var.recovery_point_retention_in_minnutes
  application_consistent_snapshot_frequency_in_minutes = var.application_consistent_snapshot_frequency_in_minutes
}

###
# Recovery service replicated VM
###

resource "azurerm_recovery_replicated_vm" "this_vm" {
  count = var.enabled ? 1 : 0

  name                                      = var.recovery_replicated_vm_names
  resource_group_name                       = var.resource_group_name
  recovery_vault_name                       = element(azurerm_recovery_service_vault.this.*.id, count.index)
  source_recovery_fabric_name               = var.source_recovery_fabric_name
  source_vm_id                              = var.recovery_replicated_source_vm_ids
  source_recovery_protection_container_name = var.source_recovery_protection_container_names
  target_resource_group_id                  = var.target_resource_group_ids
  target_recovery_fabric_id                 = var.target_recovery_fabric_ids
  target_recovery_protection_container_id   = var.target_recovery_protection_container_ids
  target_availability_set_id                = var.target_availability_set_ids

  dynamic "managed_disk" {
    for_each = var.disk_id != "" ? [1] : []

    content {
      disk_id                    = var.managed_disk_id
      staging_storage_account_id = var.managed_disk_staging_storage_account_id
      target_resource_group_id   = var.managed_disk_target_resource_group_id
      target_disk_type           = var.managed_disk_target_disk_type
      target_replica_disk_type   = var.managed_disk_target_replica_disk_type
    }
  }
}
