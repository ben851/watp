#!/bin/bash
export TF_VAR_resource_group_name=$1
echo Resource Group Name: $TF_VAR_resource_group_name
echo Fetching subscription ID
export TF_VAR_SUBSCRIPTION_ID=`az account show --subscription "Visual Studio Enterprise" --query 'id' --out tsv`
echo Subscription ID: $TF_VAR_SUBSCRIPTION_ID
echo Fetching service principal client id...
az account set --subscription=$TF_VAR_SUBSCRIPTION_ID
export TF_VAR_client_id=`az ad sp list --display-name mtssp --query '[].appId' --out tsv`
echo done... Client_ID: $TF_VAR_client_id
echo Fetching tenant ID
export TF_VAR_TENANT_ID=`az account show --subscription "Visual Studio Enterprise" --query 'tenantId' --out tsv`
echo Tenant ID: $TF_VAR_TENANT_ID
echo Fetching Client Secrets...
export TF_VAR_client_secret=MikeIsThePr0blem
echo Fetch SSH_KEY...
az keyvault secret download --name mtsssh --vault-name mtssecrets --file ../id_rsa.pub
echo done...

