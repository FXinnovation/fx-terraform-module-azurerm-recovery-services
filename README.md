# terraform-module-azurerm-recovery-services

## Usage
See `examples` folders for usage of this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | ~>1.44.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| backup\_container\_storage\_account\_ids | The list of Azure resource IDs of the storage account to be registered. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_frequency | If specified , it defines  the frequency of backups. Must be either `Daily` or `Weekly`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_policy\_file\_share\_count | Specifies the numnber of backup file share policies we would like to create. | `number` | `1` | no |
| backup\_policy\_file\_share\_daily\_retention\_count | The list of number of the daily backup to keep. Must be between `1` and `180`. | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| backup\_policy\_file\_share\_enabled | Boolean flag which describes whether or nor to enable the backup for file share policy. | `bool` | `false` | no |
| backup\_policy\_file\_share\_frequencies | The frequency of the file share backup. Currently, only `Daily` is supported. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_policy\_file\_share\_names | A list which specifies the names of the policy. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_policy\_file\_share\_times | The list of times of the day to perform the backup in 24-hour format. Times must be either on the hour or half hour(eg: `12:00`, `12:30`, `13:00`,etc). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_policy\_file\_share\_timezones | The list of the timezones. Default to `UTC`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_policy\_vm\_tags | Tags which will asssociated to the backup VM policies. | `map` | `{}` | no |
| backup\_protected\_file\_share\_enabled | Boolean flag which describes whether or not enable the backup for the protected file share. | `bool` | `false` | no |
| backup\_protected\_file\_share\_source\_file\_share\_names | Spcifies the names of the file share to backup. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_protected\_file\_share\_source\_storage\_account\_ids | The list of IDs of the stoarge account of the fileshare to backup. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_protected\_source\_vm\_ids | The IDs of the VMs to backup. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_protected\_vm\_enabled | Boolean whcih specifies to enable or not for the backup protected VMs. | `bool` | `false` | no |
| backup\_protected\_vm\_tags | Tags whcih will be associated to the backup protected VMs. | `map` | `{}` | no |
| backup\_rentntion\_weekdays | List of days of the week to perform backups on. Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_daily\_count | A list of which specifies the number of daily backups to keep. Must be between 1 and 9999. | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| backup\_retention\_monthly\_count | A list which specifies the number of monthly backups to keep. Must be between 1 and 9999. | `list(number)` | <pre>[<br>  0<br>]</pre> | no |
| backup\_retention\_monthly\_weekdays | The list weekday backups to retain . Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_monthly\_weeks | The list of weeks of the month to retain backups of. Must be one of `First`, `Second`, `Third`, `Fourth`, `Last`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_weekly\_count | A list of which specifies the of weekly backups to keep. Must be between 1 and 9999. | `list(number)` | <pre>[<br>  0<br>]</pre> | no |
| backup\_retention\_yearly\_count | A list which specifies the number of yearly backups to keep. Must be between 1 and 9999. | `list(number)` | <pre>[<br>  0<br>]</pre> | no |
| backup\_retention\_yearly\_months | The months of the year to retain backups of. Must be one of `January`, `February`, `March`, `April`, `May`, `June`, `July`, `Augest`, `September`, `October`, `November` and `December`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_yearly\_weekdays | List of weekdays backups to retain . Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_retention\_yearly\_weeks | The list of weeks of the month to retain backups of. Must be one of `First`, `Second`, `Third`, `Fourth`, `Last`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| backup\_storage\_container\_enabled | Boolean flag which describes whether or not to enable Backup for storage account containers. | `bool` | `false` | no |
| backup\_time | The list times of day to perform the backup in 24hour format. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_timezone | List which specifies the timezones. Defaults to `UTC`. | `list(string)` | <pre>[<br>  "UTC"<br>]</pre> | no |
| backup\_vm\_policy\_count | Specifies the number of backup policies we would like to create. | `number` | `1` | no |
| backup\_vm\_policy\_enabled | Boolean flag which decribes whether or not to enable the backup policy for VMs. | `bool` | `false` | no |
| backup\_vm\_policy\_id\_names | The list of names the backup policy IDs which should be used to backup the protected VMs. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_vm\_policy\_names | The names of the backup VM policies. Changing this force a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_weekdays | List of days of the week to perform backups on. Must be one of `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` or `Saturday`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| enabled | Enable or disable module. | `bool` | `true` | no |
| existing\_backup\_file\_share\_policy\_ids | The list of existing backup file share policy IDs. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| existing\_backup\_policy\_id | List of the existing backup policy IDs which will be used to backup the VMs. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| recovery\_service\_vault\_location | The supported Azure locations where the resource exists. Changing this force a new resource to be created. | `string` | n/a | yes |
| recovery\_service\_vault\_name | The name of the recovery service vaults.Changing  this forces a new resource to be created. | `string` | n/a | yes |
| recovery\_service\_vault\_sku | SKU of the service vault which will be created. Posssible values are `Standard`, `RS0`. | `string` | n/a | yes |
| recovery\_service\_vault\_soft\_delete\_enabled | Boolean flag which descibes soft delete for the vault is enabled or not. Default vaule is `true`. | `bool` | `true` | no |
| recovery\_service\_vault\_tags | Tags whcih will be associated to the recovery service vault. | `map` | `{}` | no |
| resource\_group\_name | Name of the resource group of the recovery services resources should be exist.Changing this forces a new resource to be created. | `string` | n/a | yes |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| backup\_file\_share\_policy\_ids | The IDs of the backup file share policies. |
| backup\_protected\_file\_share\_ids | The IDs of the backup protected file shares. |
| backup\_protected\_vm\_ids | The IDs of the backup protected VMs. |
| backup\_storage\_account\_conatiner\_ids | The IDs of the backup storage account container. |
| backup\_vm\_policy\_ids | The IDs of the backup VM policies. |
| recovery\_vault\_id | The ID of the recovery service vault. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
