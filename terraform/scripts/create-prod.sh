#!/bin/bash
pushd ../
pwd

terraform init

terraform apply \
-state=./watp.tfstate \
-var-file=./watp.tfvars
