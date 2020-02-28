output "recovery_service_vault_ids" {
  value = module.example.recovery_vault_id
}

output "storage_container_ids" {
  value = module.example.backup_storage_account_container_ids
}

output "backup_vm_policy_ids" {
  value = module.example.backup_vm_policy_ids
}

output "backup_protected_vm_ids" {
  value = module.example.backup_protected_vm_ids
}

output "backup_file_share_policy_ids" {
  value = module.example.backup_file_share_policy_ids
}

output "backup_protected_file_share_ids" {
  value = module.example.backup_protected_file_share_ids
}
