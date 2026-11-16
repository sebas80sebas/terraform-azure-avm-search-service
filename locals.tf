locals {
  tags = merge(var.tags, {
    module = "azure-ai-search"
  })
}
