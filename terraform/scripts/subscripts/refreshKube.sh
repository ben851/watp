#!/bin/bash
rm ~/.kube/config
az aks get-credentials --resource-group $1 --name $1-K8S
rm ~/snap/helm/common/kube/config 
cp ~/.kube/config ~/snap/helm/common/kube/
