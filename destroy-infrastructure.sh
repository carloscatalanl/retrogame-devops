#!/bin/bash 

# Infrastructure
cd terraform/infrastructure/
terraform destroy -auto-approve

# QA
cd terraform/infrastructure-qa/
terraform destroy -auto-approve

# Vault
cd terraform/vault/
terraform destroy -auto-approve