output "service_vault_ids" {
  value = module.example.recovery_vault_ids
}

output "network_mapping_ids" {
  value = module.example.recovery_network_mapping_ids
}

output "vm_protection_policy_ids" {
  value = module.example.service_protection_vm_policy_ids
}

output "protected_vm_ids" {
  value = module.example.recovery_service_protected_vm_ids
}

output "replication_policy_ids" {
  value = module.example.replication_policy_ids
}

output "replicated_vm_ids" {
  value = module.example.replicated_vm_ids
}
