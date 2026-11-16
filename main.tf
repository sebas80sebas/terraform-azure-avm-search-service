module "search_service" {
  source = "Azure/avm-res-search-searchservice/azurerm"
  version = "~> 0.1"

  location                      = var.location
  name                          = var.name
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  
  allowed_ips                   = var.allowed_ips
  authentication_failure_mode   = var.authentication_failure_mode
  customer_managed_key          = var.customer_managed_key
  diagnostic_settings           = var.diagnostic_settings
  enable_telemetry              = var.enable_telemetry
  hosting_mode                  = var.hosting_mode
  local_authentication_enabled  = var.local_authentication_enabled
  managed_identities            = var.managed_identities
  partition_count               = var.partition_count
  private_endpoints             = var.private_endpoints
  public_network_access_enabled = var.public_network_access_enabled
  replica_count                 = var.replica_count
  role_assignments              = var.role_assignments
  semantic_search_sku           = var.semantic_search_sku
  tags                          = local.tags
}
