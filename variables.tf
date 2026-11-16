variable "location" {
  type        = string
  description = "The Azure region where the resource should be created."
}

variable "name" {
  type        = string
  description = "The name of the Azure AI Search service."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Azure AI Search service should exist."
}

variable "sku" {
  type        = string
  default     = "standard"
  description = "The pricing tier of the search service (e.g., free, basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2)."
  validation {
    condition     = contains(["free", "basic", "standard", "standard2", "standard3", "storage_optimized_l1", "storage_optimized_l2"], var.sku)
    error_message = "The sku must be one of the following values: free, basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2."
  }
}

# Optional Variables

variable "allowed_ips" {
  type        = list(string)
  default     = null
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the AI Search service."
}

variable "authentication_failure_mode" {
  type        = string
  default     = null
  description = "Specifies the response that the Search Service should return for requests that fail authentication. Possible values include `http401WithBearerChallenge` or `http403`."
}

variable "customer_managed_key" {
  type = object({
    key_vault_resource_id = string
    key_name              = string
    key_version           = optional(string, null)
    user_assigned_identity = optional(object({
      resource_id = string
    }), null)
  })
  default     = null
  description = "Customer-managed keys configuration."
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default     = {}
  description = "Diagnostic settings configuration."
}

variable "hosting_mode" {
  type        = string
  default     = "default"
  description = "Specifies the Hosting Mode. Possible values are `highDensity` or `default`."
}

variable "local_authentication_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the Search Service allows authenticating using API Keys."
}

variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default     = {
    system_assigned = true
  }
  description = "Managed Identity configuration."
}

variable "partition_count" {
  type        = number
  default     = 1
  description = "Number of partitions for the Search Service."
}

variable "private_endpoints" {
  type = map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    tags                                    = optional(map(string), null)
    subnet_resource_id                      = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
  default     = {}
  description = "Private Endpoints configuration."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Controls whether or not public network access is enabled."
}

variable "replica_count" {
  type        = number
  default     = 1
  description = "Number of replicas for the Search Service."
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = "Role assignments configuration."
}

variable "semantic_search_sku" {
  type        = string
  default     = null
  description = "Specifies the Semantic Search SKU. Possible values include `free` and `standard`."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = "Controls whether or not telemetry is enabled for the module."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags to organize the resource."
}
