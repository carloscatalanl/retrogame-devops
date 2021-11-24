#!/bin/bash 

# Working dic.
cd terraform/backend/

# Terraform
terraform init
terraform apply -auto-approve