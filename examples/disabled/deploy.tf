module "example" {
  source = "../.."

  enabled                         = false
  resource_group_name             = "tftest"
  recovery_service_vault_name     = "tftest"
  recovery_service_vault_location = "Canada Central"
  recovery_service_vault_sku      = "Standard"
}
