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

variable "recovery_service_vault_name" {
  description = "The name of the recovery service vaults.Changing  this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "recovery_service_vault_location" {
  description = "The supported Azure locations where the resource exists. Changing this force a new resource to be created."
  type        = string
  default     = ""
}

variable "recovery_service_vault_sku" {
  description = "SKU of the service vault which will be created. Posssible values are `Standard`, `RS0`."
  default     = "Standard"
}

variable "recovery_service_vault_soft_delete_enabled" {
  description = "Boolean flag which descibes soft delete for the vault is enabled or not. Default vaule is `true`."
  default     = true
}

variable "recovery_service_vault_tags" {
  description = "Tags whcih will be associated to the recovery service vault."
  default     = {}
}

###
# Backup container storage account
###

variable "backup_storage_container_enabled" {
  description = "Boolean flag which describes whether or not to enable Backup for storage account containers."
  default     = false
}

variable "backup_container_storage_account_ids" {
  description = "The list of Azure resource IDs of the storage account to be registered."
  type        = list(string)
  default     = [""]
}

###
# Backup policy VM
###

variable "backup_vm_policy_enabled" {
  description = "Boolean flag which decribes whether or not to enable the backup policy for VMs."
  default     = false
}

variable "backup_vm_policy_names" {
  description = "The names of the backup VM policies. Changing this force a new resource to be created."
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

variable "backup_policy_vm_tags" {
  description = "Tags which will asssociated to the backup VM policies."
  default     = {}
}

###
# Backup protected VM
###

variable "backup_protected_vm_enabled" {
  description = "Boolean whcih specifies to enable or not for the backup protected VMs."
  default     = false
}

variable "backup_protected_source_vm_ids" {
  description = "The IDs of the VMs to backup. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "backup_vm_policy_id_names" {
  description = "The list of names the backup policy IDs which should be used to backup the protected VMs."
  type        = list(string)
  default     = [""]
}

variable "backup_protected_vm_tags" {
  description = "Tags whcih will be associated to the backup protected VMs."
  default     = {}
}

###
# Backup policy file share
###

variable "backup_policy_file_share_enabled" {
  description = "Boolean flag which describes whether or nor to enable the backup for file share policy."
  default     = false
}

variable "backup_policy_file_share_names" {
  description = "A list which specifies the names of the policy. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "backup_policy_file_share_timezones" {
  description = "The list of the timezones. Default to `UTC`."
  type        = list(string)
  default     = [""]
}

variable "backup_policy_file_share_frequency" {
  description = "The frequency of the file share backup. Currently, only `Daily` is supported."
  type        = string
  default     = ""
}

variable "backup_policy_file_share_count" {
  description = "The list of times of the day to perform the backup in 24-hour format. Times must be either on the hour or half hour(eg: `12:00`, `12:30`, `13:00`,etc)."
  type        = list(string)
  default     = [""]
}

variable "backup_policy_file_share_daily_retention_count" {
  description = "The list of number of the daily backup to keep. Must be between `1` and `180`."
  type        = list(number)
  default     = [1]
}


###
# Backup protected file share
###

variable "backup_protected_file_share_enabled" {
  description = "Boolean flag which describes whether or not enable the backup for the protected file share."
  default     = false
}

variable "backup_protected_file_share_source_storage_account_ids" {
  description = "The list of IDs of the stoarge account of the fileshare to backup. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "backup_protected_file_share_source_file_share_names" {
  description = "Spcifies the names of the file share to backup. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}
