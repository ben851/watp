resource "azurerm_dns_zone" "watp" {
  name                = "wearetheproblem.ca"
  resource_group_name = ""
  zone_type           = "Public"
}
