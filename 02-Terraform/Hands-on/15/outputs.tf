output "storage_account_id" {
  value = data.azurerm_storage_account.storage.id
}

output "primary_blob_endpoint" {
  value = data.azurerm_storage_account.storage.primary_blob_endpoint
}

output "blob_url" {
  value = azurerm_storage_blob.blob.url
}
