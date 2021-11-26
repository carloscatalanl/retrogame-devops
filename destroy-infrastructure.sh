#!/bin/bash 

# Infrastructure
cd terraform/infrastructure/
terraform destroy -auto-approve

# QA
cd terraform/infrastructure-qa/
terraform destroy -auto-approve

# Vault
cd terraform/vault/
terraform destroy -var admin_password="1234" -auto-approve