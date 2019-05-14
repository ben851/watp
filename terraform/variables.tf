variable "client_id" {}
variable "client_secret" {}
variable "SUBSCRIPTION_ID" {}
variable "TENANT_ID" {}
variable "resource_group_name" {}
variable "agent_count" {}
variable "environment" {
    default = "development"
}
variable "ssh_public_key" {
    default = "./id_rsa.pub"
}
variable "vm_size" {
    default ="Standard_D2_v2"
}

