provider "azurerm" {
  version         = "=1.38.0"
  subscription_id = ""
}

module "azure-recovery-services" {
  source = "../.."

  resource_group_name = ""
  recovery_vault_name = "test"
  source_vm_ids       = [""]

  backup_frequency                  = "Daily"
  backup_time                       = "23:00"
  backup_weekdays                   = ["Sunday"]
  backup_timezone                   = "America/Toronto"
  backup_retention_daily_count      = "31"
  backup_retention_weekly_count     = "5"
  backup_retention_monthly_count    = "12"
  backup_retention_monthly_weekdays = ["Sunday"]
  backup_retention_monthly_weeks    = ["First"]
  backup_retention_yearly_count     = 7
  backup_retention_yearly_weekdays  = ["Sunday"]
  backup_retention_yearly_weeks     = ["First"]
  backup_retention_yearly_months    = ["January"]
}
