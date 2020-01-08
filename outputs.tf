output "recovery_vault_id" {
  value = azurerm_recovery_services_vault.this.id
}

output "recovery_services_policy_id" {
  value = azurerm_recovery_services_protection_policy_vm.this.id
}

output "recovery_services_protection_policy_vm_ids" {
  value = azurerm_recovery_services_protection_policy_vm.this.*.id
}
