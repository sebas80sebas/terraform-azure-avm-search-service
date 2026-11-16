output "private_endpoints" {
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
  value       = module.search_service.private_endpoints
}

output "resource" {
  description = "This is the full output for the resource."
  value       = module.search_service.resource
}

output "resource_id" {
  description = "The ID of the machine learning workspace (Search Service)."
  value       = module.search_service.resource_id
}
