provider "azurerm" {
  subscription_id = "${var.SUBSCRIPTION_ID}"
  tenant_id = "${var.TENANT_ID}"
}

resource "azurerm_resource_group" "WATP" {
  name     = "WATP"
  location = "Canada East"
}

module "sp" {
  source  = "CalvinRodo/service-principle/azurerm"
  version = "1.0.2"
  sp_name = "${azurerm_resource_group.MTSCloud.name}-sp"
}

module "aks" {
  source = "git@github.com:mts-stm/aks-kubernetes.git"
  aks_resource_group_name = "${azurerm_resource_group.MTSCloud.name}"
  aks_cluster_name = "${azurerm_resource_group.MTSCloud.name}-K8S"
  agent_pool_profile_count = "${var.agent_count}"
  vm_size = "${var.vm_size}"
  dns_prefix = "${azurerm_resource_group.MTSCloud.name}"
  environment = "${var.environment}"
  client_id = "${module.sp.client_id}"
  client_secret = "${module.sp.client_secret}"
  key_data = "${file("${var.ssh_public_key}")}"
}

# We need to generate a static IP in order to automate ingress to dns
resource "azurerm_public_ip" "WATPCloud" {
  name                         = "${azurerm_resource_group.MTSCloud.name}-ip"
  location                     = "${azurerm_resource_group.MTSCloud.location}"
  resource_group_name          = "${module.aks.node_resource_group}"
  public_ip_address_allocation = "static"

  tags {
    environment = "${var.environment}"
  }
}

