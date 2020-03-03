###
# Recovery service vault
###

output "recovery_vault_id" {
  description = "The ID of the recovery service vault."
  value       = element(concat(azurerm_recovery_services_vault.this.*.id, list("")), 0)
}

###
# Backup container storage account
###

output "backup_storage_account_container_ids" {
  description = "The IDs of the backup storage account container."
  value       = compact(concat(azurerm_backup_container_storage_account.this_container.*.id, [""]))
}

###
# Backup policy VM
###

output "backup_vm_policy_ids" {
  description = "The IDs of the backup VM policies."
  value       = compact(concat(azurerm_backup_policy_vm.this.*.id, [""]))
}

###
# Backup protected VM
###

output "backup_protected_vm_ids" {
  description = "The IDs of the backup protected VMs."
  value       = compact(concat(azurerm_backup_protected_vm.this_vm.*.id, [""]))
}

###
# Backup policy file share
###

output "backup_file_share_policy_ids" {
  description = "The IDs of the backup file share policies."
  value       = compact(concat(azurerm_backup_policy_file_share.this.*.id, [""]))
}

###
# Backup protected file share
###

output "backup_protected_file_share_ids" {
  description = "The IDs of the backup protected file shares."
  value       = compact(concat(azurerm_backup_protected_file_share.this.*.id, [""]))
}
