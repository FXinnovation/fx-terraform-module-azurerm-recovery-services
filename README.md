# terraform-module-azurerm-recovery-services

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| backup\_frequency | Frequency of backups. Must be either Daily or Weekly. | `string` | n/a | yes |
| backup\_retention\_daily\_count | The number of daily backups to keep. Must be between 1 and 9999. | `string` | `0` | no |
| backup\_retention\_monthly\_count | The number of monthly backups to keep. Must be between 1 and 9999. | `string` | `0` | no |
| backup\_retention\_monthly\_weekdays | The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday. | `list` | `[]` | no |
| backup\_retention\_monthly\_weeks | The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last. | `list` | `[]` | no |
| backup\_retention\_weekly\_count | The number of weekly backups to keep. Must be between 1 and 9999. | `string` | `0` | no |
| backup\_retention\_yearly\_count | The number of yearly backups to keep. Must be between 1 and 9999. | `string` | `0` | no |
| backup\_retention\_yearly\_months | The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December. | `list` | `[]` | no |
| backup\_retention\_yearly\_weekdays | The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday. | `list` | `[]` | no |
| backup\_retention\_yearly\_weeks | The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last. | `list` | `[]` | no |
| backup\_time | The time of day to perform the backup in 24hour format. | `string` | n/a | yes |
| backup\_timezone | Specifies the timezone. Defaults to UTC. | `string` | `"UTC"` | no |
| backup\_weekdays | The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday. | `list` | `[]` | no |
| recovery\_vault\_name | Name of the recovery vault. | `string` | n/a | yes |
| resource\_group\_name | Name of the resource group of the recovery services vault. | `string` | n/a | yes |
| source\_vm\_ids | Specifies the IDs of the VMs to backup. Changing these forces new resources to be created. | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| recovery\_services\_policy\_id | n/a |
| recovery\_services\_protection\_policy\_vm\_ids | n/a |
| recovery\_vault\_id | n/a |
