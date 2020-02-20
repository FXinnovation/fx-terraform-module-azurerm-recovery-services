# terraform-module-azurerm-recovery-services

## Usage
See `examples` folders for usage of this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | ~>1.43.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| application\_consistent\_snapshot\_frequency\_in\_minutes | A list which specifies the frequency(in minutes) at which to create application consistent recovery points. | `list(number)` | <pre>[<br>  0<br>]</pre> | no |
| backup\_frequency | If specified , it defines  the frequency of backups. Must be either `Daily` or `Weekly`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_rentntion\_weekdays | List of days of the week to perform backups on. Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_daily\_count | A list of which specifies the number of daily backups to keep. Must be between 1 and 9999. | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| backup\_retention\_monthly\_count | A list which specifies the number of monthly backups to keep. Must be between 1 and 9999. | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| backup\_retention\_monthly\_weekdays | The list weekday backups to retain . Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_monthly\_weeks | The list of weeks of the month to retain backups of. Must be one of `First`, `Second`, `Third`, `Fourth`, `Last`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_retention\_weekly\_count | A list of which specifies the of weekly backups to keep. Must be between 1 and 9999. | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| backup\_retention\_yearly\_count | A list which specifies the number of yearly backups to keep. Must be between 1 and 9999. | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| backup\_retention\_yearly\_months | The months of the year to retain backups of. Must be one of `January`, `February`, `March`, `April`, `May`, `June`, `July`, `Augest`, `September`, `October`, `November` and `December`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_yearly\_weekdays | List of weekdays backups to retain . Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_yearly\_weeks | The list of weeks of the month to retain backups of. Must be one of `First`, `Second`, `Third`, `Fourth`, `Last`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_time | The list times of day to perform the backup in 24hour format. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_timezone | List which specifies the timezones. Defaults to `UTC`. | `list(string)` | <pre>[<br>  "UTC"<br>]</pre> | no |
| backup\_weekdays | List of days of the week to perform backups on. Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| enabled | Enable or disable module. | `bool` | `true` | no |
| managed\_disk\_id | The IDs of the managed disk that should be replicated. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_staging\_storage\_account\_id | The IDs of the storage account that should be used for caching. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_target\_disk\_type | List which specifies what type should the disk be when a failover is done. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_target\_replica\_disk\_type | List whicg describes what type should the disk be that holds the replication data. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_target\_resource\_group\_id | The IDs of the resource group whih the disk belong to when a failover is done. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_network\_mapping\_names | The names of the recovery network mappings. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_point\_retention\_in\_minnutes | Retains the recovery points for the given time in minutes. | `list(number)` | <pre>[<br>  0<br>]</pre> | no |
| recovery\_replicated\_source\_vm\_ids | The IDs of the VMs to replicate. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_replicated\_vm\_names | List of names of the VMs which will be replicated. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_service\_protected\_source\_vm\_ids | The IDs of the VMs to backup. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_service\_protection\_policy\_vm\_names | The names of the Recovery Service Vault Policy. Changing this force a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_service\_replication\_policy\_names | The list of names of the recovery service replication policy. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_service\_vault\_locations | The supported Azure locations where the resource exists. Changing this force a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_service\_vault\_names | The names of the recovery service vaults.Changing  this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_service\_vault\_skus | SKUs of the service vault which will be created. Posssible values are `Standard`, `RS0`. | `list` | <pre>[<br>  "Standard"<br>]</pre> | no |
| recovery\_service\_vault\_soft\_delete\_enabled | Boolean flag which descibes soft delete for the vault is enabled or not. Default vaule is `true`. | `bool` | `true` | no |
| resource\_group\_name | Name of the resource group of the recovery services resources should be exist.Changing this forces a new resource to be created. | `string` | `""` | no |
| source\_network\_ids | The IDs of the primary networks. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| source\_recover\_fabric\_names | Specifies the names of ASR fabric where mapping should be created. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| source\_recovery\_protection\_container\_names | List which specifies the names of the protection containers to use. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| source\_vm\_ids | Specifies the IDs of the VMs to backup. Changing these forces new resources to be created. | `list` | n/a | yes |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource. | `map` | `{}` | no |
| target\_availability\_set\_ids | IDs of the availability set that the new VMs should belong to when a failover is done. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| target\_network\_ids | the IDs of the recovery networks. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| target\_recovery\_fabric\_ids | The IDs of the service fabric where the VMs replication should be handled when a failover is done. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| target\_recovery\_fabric\_names | Specifies the names of the Azure site recovery fabric object corresponding to the recovery Azure region. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| target\_recovery\_protection\_container\_ids | IDs of the protection containers where the VM replication should be created when a failover is done. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| target\_resource\_group\_ids | The IDs of the resource group where the VMs should be created when a failover is done. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| recovery\_network\_mapping\_ids | The IDs of the site recovery network mappings. |
| recovery\_service\_protected\_vm\_ids | The IDs of the recovery service protected VMs. |
| recovery\_vault\_id | The IDs of the recovery service vault. |
| replicated\_vm\_ids | The IDs of the recovery service replicated VMs |
| replication\_policy\_ids | The IDs of the recovery service replication policy. |
| service\_protection\_vm\_policy\_ids | The IDs of the recovery service VM protection policy. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
