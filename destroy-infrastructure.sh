#!/bin/bash 

# Infrastructure 
cd terraform/infrastructure/
terraform destroy -auto-approve

# Vault
cd ../vault/
terraform destroy -auto-approve