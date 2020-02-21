locals {
  should_create_recovery_network_mapping               = var.enabled && var.network_mapping_enabled
  should_create_recovery_service_protection_policy_vms = var.enabled && var.vm_protection_policy_enabled
  should_create_recovery_service_protected_vms         = var.enabled && var.service_protected_vm_enabled
  should_create_replication_policy                     = var.enabled && var.policy_replication_enabled
  should_create_replicated_vms                         = var.enabled && var.vm_replication_enabled
}


###
# Recovery service vault
###

resource "azurerm_recovery_services_vault" "this" {
  count = var.enabled ? 1 : 0

  name                = element(var.recovery_service_vault_names, count.index)
  location            = element(var.recovery_service_vault_locations, count.index)
  resource_group_name = var.resource_group_name
  sku                 = element(var.recovery_service_vault_skus, count.index)
  soft_delete_enabled = element(var.recovery_service_vault_soft_delete_enabled, count.index)

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
  count = local.should_create_recovery_network_mapping ? 1 : 0

  name                        = var.recovery_network_mapping_names
  resource_group_name         = var.resource_group_name
  recovery_vault_name         = element(azurerm_recovery_services_vault.this.*.id, count.index)
  source_recovery_fabric_name = var.network_mapping_source_recovery_fabric_names
  target_recovery_fabric_name = var.network_mapping_target_recovery_fabric_names
  source_network_id           = var.network_mapping_source_network_ids
  target_network_id           = var.network_mapping_target_network_ids
}

###
# Recovery service protection policy VM
###

resource "azurerm_recovery_services_protection_policy_vm" "this" {
  count = local.should_create_recovery_service_protection_policy_vms ? 1 : 0

  name                = var.recovery_service_protection_policy_vm_names[count.index]
  resource_group_name = var.resource_group_name
  recovery_vault_name = element(azurerm_recovery_services_vault.this.*.id, count.index)

  timezone = var.backup_timezone[count.index]

  dynamic "backup" {
    for_each = var.backup_frequency[count.index] != "" ? [1] : []

    content {
      frequency = var.backup_frequency
      time      = var.backup_time
      weekdays  = var.backup_frequency == "Weekly" ? var.backup_weekdays : []
    }
  }

  dynamic "retention_daily" {
    for_each = var.backup_frequency[count.index] == "Daily" ? [1] : []

    content {
      count = var.backup_retention_daily_count
    }
  }

  dynamic "retention_weekly" {
    for_each = var.backup_retention_weekly_count[count.index] > 0 || var.backup_frequency == "Weekly" ? [1] : []

    content {
      count    = var.backup_retention_weekly_count
      weekdays = var.backup_rentntion_weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = var.backup_retention_monthly_count[count.index] > 0 ? [1] : []

    content {
      count    = var.backup_retention_monthly_count
      weekdays = var.backup_retention_monthly_weekdays
      weeks    = var.backup_retention_monthly_weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = var.backup_retention_yearly_count[count.index] > 0 ? [1] : []

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
  count = local.should_create_recovery_service_protected_vms ? length(var.recovery_service_protected_source_vm_ids) : 0

  resource_group_name = var.resource_group_name
  recovery_vault_name = element(azurerm_recovery_services_vault.this.*.id, count.index)
  source_vm_id        = var.recovery_service_protected_source_vm_ids[count.index]
  backup_policy_id    = element(azurerm_recovery_services_protection_policy_vm.this.*.id, count.index)
}

###
# Recovery service replication policy
###

resource "azurerm_recovery_services_replication_policy" "this_policy" {
  count = local.should_create_replication_policy ? 1 : 0

  name                                                 = element(var.replication_policy_names, count.index)
  resource_group_name                                  = var.resource_group_name
  recovery_vault_name                                  = element(azurerm_recovery_services_vault.this.*.id, count.index)
  recovery_point_retention_in_minutes                  = element(var.replication_policy_recovery_point_retention_in_minnutes, count.index)
  application_consistent_snapshot_frequency_in_minutes = element(var.replication_policy_application_consistent_snapshot_frequency_in_minutes, count.index)
}

###
# Recovery service replicated VM
###

resource "azurerm_recovery_replicated_vm" "this_vm" {
  count = local.should_create_replicated_vms ? 1 : 0

  name                                      = var.replicated_vm_names[count.index]
  resource_group_name                       = var.resource_group_name
  recovery_vault_name                       = element(azurerm_recovery_services_vault.this.*.id, count.index)
  recovery_replication_policy_id            = element(azurerm_recovery_services_replication_policy.this_policy.*.id, count.index)
  source_recovery_fabric_name               = var.replicated_vm_source_recovery_fabric_names[count.index]
  source_vm_id                              = var.replicated_vm_source_vm_ids[count.index]
  source_recovery_protection_container_name = var.replicated_vm_source_recovery_protection_container_names[count.index]
  target_resource_group_id                  = var.replicated_vm_target_resource_group_ids[count.index]
  target_recovery_fabric_id                 = var.replicated_vm_target_recovery_fabric_ids[count.index]
  target_recovery_protection_container_id   = var.replicated_vm_target_recovery_protection_container_ids[count.index]
  target_availability_set_id                = var.replicated_vm_target_availability_set_ids[count.index]

  dynamic "managed_disk" {
    for_each = var.managed_disk_ids[count.index] != "" ? [1] : []

    content {
      disk_id                    = var.managed_disk_ids
      staging_storage_account_id = var.managed_disk_staging_storage_account_ids
      target_resource_group_id   = var.managed_disk_target_resource_group_ids
      target_disk_type           = var.managed_disk_target_disk_types
      target_replica_disk_type   = var.managed_disk_target_replica_disk_types
    }
  }
}
