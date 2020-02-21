###
# Recovery service vault
###

output "recovery_vault_ids" {
  description = "The IDs of the recovery service vault."
  value       = azurerm_recovery_services_vault.this.*.ids
}

###
# Recovery network mapping
###

output "recovery_network_mapping_ids" {
  description = "The IDs of the site recovery network mappings."
  value       = azurerm_recovery_network_mapping.this.*.id
}

###
# Recovery service protection policy VM
###

output "service_protection_vm_policy_ids" {
  description = "The IDs of the recovery service VM protection policy."
  value       = azurerm_recovery_services_protection_policy_vm.this.*.id
}

###
# Recovery service protected VM
###

output "recovery_service_protected_vm_ids" {
  description = "The IDs of the recovery service protected VMs."
  value       = azurerm_recovery_services_protected_vm.this_vm.*.ids
}

###
# Recovery service replication policy
###

output "replication_policy_ids" {
  description = "The IDs of the recovery service replication policy."
  value       = azurerm_recovery_services_replication_policy.this_policy.*.id
}

###
# Recovery service replicated VM
###

output "replicated_vm_ids" {
  description = "The IDs of the recovery service replicated VMs"
  value       = azurerm_recovery_replicated_vm.this_vm.*.id
}
