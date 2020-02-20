###
# General
###

variable "enabled" {
  description = "Enable or disable module."
  default     = true
}

variable "resource_group_name" {
  description = "Name of the resource group of the recovery services resources should be exist.Changing this forces a new resource to be created."
  default     = ""
}

variable "tags" {
  description = "Tags shared by all resources of this module. Will be merged with any other specific tags by resource."
  default     = {}
}

###
# Recovery service vault
###

variable "recovery_service_vault_names" {
  description = "The names of the recovery service vaults.Changing  this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "recovery_service_vault_locations" {
  description = "The supported Azure locations where the resource exists. Changing this force a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "recovery_service_vault_skus" {
  description = "SKUs of the service vault which will be created. Posssible values are `Standard`, `RS0`."
  default     = ["Standard"]
}

variable "recovery_service_vault_soft_delete_enabled" {
  description = "Boolean flag which descibes soft delete for the vault is enabled or not. Default vaule is `true`."
  default     = true
}

###
# Recovery network mapping
###

variable "recovery_network_mapping_names" {
  description = "The names of the recovery network mappings."
  default     = [""]
}

variable "source_recover_fabric_names" {
  description = "Specifies the names of ASR fabric where mapping should be created."
  default     = [""]
}

variable "target_recovery_fabric_names" {
  description = "Specifies the names of the Azure site recovery fabric object corresponding to the recovery Azure region."
  default     = [""]
}

variable "source_network_ids" {
  description = "The IDs of the primary networks."
  default     = [""]
}

variable "target_network_ids" {
  description = "the IDs of the recovery networks."
  default     = [""]
}

###
# Recovery service protection policy VM
###

variable "recovery_service_protection_policy_vm_names" {
  description = "The names of the Recovery Service Vault Policy. Changing this force a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "backup_timezone" {
  description = "List which specifies the timezones. Defaults to `UTC`."
  type        = list(string)
  default     = ["UTC"]
}

variable "backup_frequency" {
  description = "If specified , it defines  the frequency of backups. Must be either `Daily` or `Weekly`."
  type        = list(string)
  default     = [""]
}

variable "backup_time" {
  description = "The list times of day to perform the backup in 24hour format."
  type        = list(string)
  default     = [""]
}

variable "backup_weekdays" {
  description = "List of days of the week to perform backups on. Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`."
  type        = list(list(string))
  default     = [null]
}

variable "backup_retention_daily_count" {
  description = "A list of which specifies the number of daily backups to keep. Must be between 1 and 9999."
  type        = list(number)
  default     = [1]
}
variable "backup_retention_weekly_count" {
  description = "A list of which specifies the of weekly backups to keep. Must be between 1 and 9999."
  type        = list(number)
  default     = [1]
}

variable "source_vm_ids" {
  description = "Specifies the IDs of the VMs to backup. Changing these forces new resources to be created."
  type        = list
}

variable "backup_rentntion_weekdays" {
  description = "List of days of the week to perform backups on. Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`."
  type        = list(list(string))
  default     = [null]
}

variable "backup_retention_monthly_count" {
  description = "A list which specifies the number of monthly backups to keep. Must be between 1 and 9999."
  type        = list(number)
  default     = [1]
}

variable "backup_retention_monthly_weekdays" {
  description = "The list weekday backups to retain . Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`."
  type        = list(list(string))
  default     = [null]
}

variable "backup_retention_monthly_weeks" {
  description = "The list of weeks of the month to retain backups of. Must be one of `First`, `Second`, `Third`, `Fourth`, `Last`."
  type        = list(string)
  default     = [""]
}

variable "backup_retention_yearly_count" {
  description = "A list which specifies the number of yearly backups to keep. Must be between 1 and 9999."
  type        = list(number)
  default     = [1]
}

variable "backup_retention_yearly_weekdays" {
  description = "List of weekdays backups to retain . Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`."
  type        = list(list(string))
  default     = [null]
}

variable "backup_retention_yearly_weeks" {
  description = "The list of weeks of the month to retain backups of. Must be one of `First`, `Second`, `Third`, `Fourth`, `Last`."
  type        = list(string)
  default     = [""]
}

variable "backup_retention_yearly_months" {
  description = "The months of the year to retain backups of. Must be one of `January`, `February`, `March`, `April`, `May`, `June`, `July`, `Augest`, `September`, `October`, `November` and `December`."
  type        = list(list(string))
  default     = [null]
}

###
# Recovery service protected VM
###

variable "recovery_service_protected_source_vm_ids" {
  description = "The IDs of the VMs to backup. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}


###
# Recovery service replication policy
###

variable "recovery_service_replication_policy_names" {
  description = "The list of names of the recovery service replication policy."
  type        = list(string)
  default     = [""]
}

variable "recovery_point_retention_in_minnutes" {
  description = "Retains the recovery points for the given time in minutes."
  type        = list(number)
  default     = [0]
}

variable "application_consistent_snapshot_frequency_in_minutes" {
  description = "A list which specifies the frequency(in minutes) at which to create application consistent recovery points."
  type        = list(number)
  default     = [0]
}

###
# Recovery service replicated VM
###

variable "recovery_replicated_vm_names" {
  description = "List of names of the VMs which will be replicated."
  type        = list(string)
  default     = [""]
}

variable "recovery_replicated_source_vm_ids" {
  description = "The IDs of the VMs to replicate."
  type        = list(string)
  default     = [""]
}

variable "source_recovery_protection_container_names" {
  description = "List which specifies the names of the protection containers to use."
  type        = list(string)
  default     = [""]
}

variable "target_resource_group_ids" {
  description = "The IDs of the resource group where the VMs should be created when a failover is done."
  type        = list(string)
  default     = [""]
}

variable "target_recovery_fabric_ids" {
  description = "The IDs of the service fabric where the VMs replication should be handled when a failover is done."
  type        = list(string)
  default     = [""]
}

variable "target_recovery_protection_container_ids" {
  description = "IDs of the protection containers where the VM replication should be created when a failover is done."
  type        = list(string)
  default     = [""]
}

variable "target_availability_set_ids" {
  description = "IDs of the availability set that the new VMs should belong to when a failover is done."
  type        = list(string)
  default     = [""]
}

variable "managed_disk_id" {
  description = "The IDs of the managed disk that should be replicated."
  type        = list(string)
  default     = [""]
}

variable "managed_disk_staging_storage_account_id" {
  description = "The IDs of the storage account that should be used for caching."
  type        = list(string)
  default     = [""]
}

variable "managed_disk_target_resource_group_id" {
  description = "The IDs of the resource group whih the disk belong to when a failover is done."
  type        = list(string)
  default     = [""]
}

variable "managed_disk_target_disk_type" {
  description = "List which specifies what type should the disk be when a failover is done."
  type        = list(string)
  default     = [""]
}

variable "managed_disk_target_replica_disk_type" {
  description = "List whicg describes what type should the disk be that holds the replication data."
  type        = list(string)
  default     = [""]
}
