# Terraform Azure AI Search Module

This module is an **Azure Verified Module (AVM) Wrapper** for deploying Azure AI Search services. It provides a simplified interface for the official Microsoft AVM module and can be integrated into Azure landing zone deployments.

## Features

- **Search Service**: Deploy and configure Azure AI Search services with various SKUs (free, basic, standard, storage_optimized).
- **Security**: Support for Managed Identities (System & User), Customer Managed Keys (CMK), and Role Based Access Control (RBAC).
- **Networking**: Private Endpoint support and Public Network Access control.
- **Observability**: Integrated Diagnostic Settings and Telemetry tracking.
- **Scalability**: Configure replica and partition counts for high availability and performance.

## Folder Structure

The module follows the standard Azure Verified Module (AVM) layout:

- `.config/`: AVM configuration metadata.
- `.github/`: CI/CD workflows for validation.
- `examples/`: Comprehensive usage scenarios.
- `main.tf`: Core logic wrapping the official AVM module.
- `variables.tf`: Input variable definitions matching official standards.
- `outputs.tf`: Module outputs.
- `CHANGELOG`: Version history and updates.

## Testing and Verification

To verify that this module works correctly, you can use the provided examples in the `examples/` folder.

### 1. Manual Validation

Run the following commands inside the module root to validate the code:

```bash
terraform init -backend=false
terraform validate
```

### 2. Integration Test (Plan)

To see what resources will be created without actually deploying them:

```bash
cd examples/default
# Set your Azure subscription (required)
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
terraform init
terraform plan
```

### 3. Full Deployment Test

If you have a testing environment, you can deploy any of the examples:

```bash
cd examples/default
terraform apply -auto-approve
# After verification, destroy the resources
terraform destroy -auto-approve
```

## Usage

```hcl
module "aisearch" {
  source = "git::https://github.com/sebas80sebas/terraform-azure-avm-search-service.git"

  location            = "East US"
  name                = "aisearch-prod"
  resource_group_name = "rg-search"
  sku                 = "standard"

  tags = {
    environment = "dev"
  }
}
```

## Examples

- [Default](./examples/default): A basic deployment using default settings.
- [Private Endpoint](./examples/private-endpoint): Advanced deployment with Private Endpoint, VNET, and DNS configuration.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9, < 2.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.116, < 5.0 |
| <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) | ~> 0.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 2.9.0 |
| <a name="provider_modtm"></a> [modtm](#provider\_modtm) | 0.3.5 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.8.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_search_service"></a> [search\_service](#module\_search\_service) | Azure/avm-res-search-searchservice/azurerm | ~> 0.1 |

## Resources

| Name | Type |
|------|------|
| [modtm_telemetry.telemetry](https://registry.terraform.io/providers/Azure/modtm/latest/docs/resources/telemetry) | resource |
| [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [azapi_client_config.telemetry](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/client_config) | data source |
| [modtm_module_source.telemetry](https://registry.terraform.io/providers/Azure/modtm/latest/docs/data-sources/module_source) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | One or more IP Addresses, or CIDR Blocks which should be able to access the AI Search service. | `list(string)` | `null` | no |
| <a name="input_authentication_failure_mode"></a> [authentication\_failure\_mode](#input\_authentication\_failure\_mode) | Specifies the response that the Search Service should return for requests that fail authentication. Possible values include `http401WithBearerChallenge` or `http403`. | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | Customer-managed keys configuration. | <pre>object({<br/>    key_vault_resource_id = string<br/>    key_name              = string<br/>    key_version           = optional(string, null)<br/>    user_assigned_identity = optional(object({<br/>      resource_id = string<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | Diagnostic settings configuration. | <pre>map(object({<br/>    name                                     = optional(string, null)<br/>    log_categories                           = optional(set(string), [])<br/>    log_groups                               = optional(set(string), ["allLogs"])<br/>    metric_categories                        = optional(set(string), ["AllMetrics"])<br/>    log_analytics_destination_type           = optional(string, "Dedicated")<br/>    workspace_resource_id                    = optional(string, null)<br/>    storage_account_resource_id              = optional(string, null)<br/>    event_hub_authorization_rule_resource_id = optional(string, null)<br/>    event_hub_name                           = optional(string, null)<br/>    marketplace_partner_resource_id          = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry) | Controls whether or not telemetry is enabled for the module. | `bool` | `true` | no |
| <a name="input_hosting_mode"></a> [hosting\_mode](#input\_hosting\_mode) | Specifies the Hosting Mode. Possible values are `highDensity` or `default`. | `string` | `"default"` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | Specifies whether the Search Service allows authenticating using API Keys. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the resource should be created. | `string` | n/a | yes |
| <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities) | Managed Identity configuration. | <pre>object({<br/>    system_assigned            = optional(bool, false)<br/>    user_assigned_resource_ids = optional(set(string), [])<br/>  })</pre> | <pre>{<br/>  "system_assigned": true<br/>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure AI Search service. | `string` | n/a | yes |
| <a name="input_partition_count"></a> [partition\_count](#input\_partition\_count) | Number of partitions for the Search Service. | `number` | `1` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoints configuration. | <pre>map(object({<br/>    name = optional(string, null)<br/>    role_assignments = optional(map(object({<br/>      role_definition_id_or_name             = string<br/>      principal_id                           = string<br/>      description                            = optional(string, null)<br/>      skip_service_principal_aad_check       = optional(bool, false)<br/>      condition                              = optional(string, null)<br/>      condition_version                      = optional(string, null)<br/>      delegated_managed_identity_resource_id = optional(string, null)<br/>      principal_type                         = optional(string, null)<br/>    })), {})<br/>    lock = optional(object({<br/>      kind = string<br/>      name = optional(string, null)<br/>    }), null)<br/>    tags                                    = optional(map(string), null)<br/>    subnet_resource_id                      = string<br/>    private_dns_zone_group_name             = optional(string, "default")<br/>    private_dns_zone_resource_ids           = optional(set(string), [])<br/>    application_security_group_associations = optional(map(string), {})<br/>    private_service_connection_name         = optional(string, null)<br/>    network_interface_name                  = optional(string, null)<br/>    location                                = optional(string, null)<br/>    resource_group_name                     = optional(string, null)<br/>    ip_configurations = optional(map(object({<br/>      name               = string<br/>      private_ip_address = string<br/>    })), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Controls whether or not public network access is enabled. | `bool` | `true` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Number of replicas for the Search Service. | `number` | `1` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the Azure AI Search service should exist. | `string` | n/a | yes |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | Role assignments configuration. | <pre>map(object({<br/>    role_definition_id_or_name             = string<br/>    principal_id                           = string<br/>    description                            = optional(string, null)<br/>    skip_service_principal_aad_check       = optional(bool, false)<br/>    condition                              = optional(string, null)<br/>    condition_version                      = optional(string, null)<br/>    delegated_managed_identity_resource_id = optional(string, null)<br/>    principal_type                         = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_semantic_search_sku"></a> [semantic\_search\_sku](#input\_semantic\_search\_sku) | Specifies the Semantic Search SKU. Possible values include `free` and `standard`. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The pricing tier of the search service (e.g., free, basic, standard, standard2, standard3, storage\_optimized\_l1, storage\_optimized\_l2). | `string` | `"standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to organize the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_endpoints"></a> [private\_endpoints](#output\_private\_endpoints) | A map of private endpoints. The map key is the supplied input to var.private\_endpoints. The map value is the entire azurerm\_private\_endpoint resource. |
| <a name="output_resource"></a> [resource](#output\_resource) | This is the full output for the resource. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The ID of the machine learning workspace (Search Service). |
<!-- END_TF_DOCS -->
