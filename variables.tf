variable "resource_group_name" {
  description = "Name of the resource group of the recovery services vault."
  type        = string
}

variable "recovery_vault_name" {
  description = "Name of the recovery vault."
  type        = string
}

variable "source_vm_ids" {
  description = "Specifies the IDs of the VMs to backup. Changing these forces new resources to be created."
  type        = list
}

variable "backup_frequency" {
  description = "Frequency of backups. Must be either Daily or Weekly."
  type        = string
}

variable "backup_time" {
  description = "The time of day to perform the backup in 24hour format."
  type        = string
}

variable "backup_weekdays" {
  description = "The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  type        = list
  default     = []
}

variable "backup_timezone" {
  description = "Specifies the timezone. Defaults to UTC."
  type        = string
  default     = "UTC"
}

variable "backup_retention_daily_count" {
  description = "The number of daily backups to keep. Must be between 1 and 9999."
  type        = string
  default     = 0
}

variable "backup_retention_weekly_count" {
  description = "The number of weekly backups to keep. Must be between 1 and 9999."
  type        = string
  default     = 0
}

variable "backup_retention_monthly_count" {
  description = "The number of monthly backups to keep. Must be between 1 and 9999."
  type        = string
  default     = 0
}

variable "backup_retention_monthly_weekdays" {
  description = "The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  type        = list
  default     = []
}

variable "backup_retention_monthly_weeks" {
  description = "The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last."
  type        = list
  default     = []
}

variable "backup_retention_yearly_count" {
  description = "The number of yearly backups to keep. Must be between 1 and 9999."
  type        = string
  default     = 0
}

variable "backup_retention_yearly_weekdays" {
  description = "The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
  type        = list
  default     = []
}

variable "backup_retention_yearly_weeks" {
  description = "The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last."
  type        = list
  default     = []
}

variable "backup_retention_yearly_months" {
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December."
  type        = list
  default     = []
}
