## Disabled example

## Usage
```
terraform init
terraform plan
terraform apply
terraform destroy
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\_id | Azure service principal application Id. | `string` | n/a | yes |
| client\_secret | Azure service principal application Secret. | `string` | n/a | yes |
| subscription\_id | Azure subscription Id. | `string` | n/a | yes |
| tenant\_id | Azure tenant Id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| backup\_file\_share\_policy\_ids | n/a |
| backup\_protected\_file\_share\_ids | n/a |
| backup\_protected\_vm\_ids | n/a |
| backup\_vm\_policy\_ids | n/a |
| recovery\_service\_vault\_ids | n/a |
| storage\_container\_ids | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
