#!/bin/bash


# FILE=account.json
# if [ -f "$FILE" ]; then
#   echo "Service account JSON key file exists.  Let's Terraform a GKE cluster, shall we?"
# else
#   echo "A Service account JSON key file named [ account.json ] DOES NOT exist.  Have you prepared your environment? Try running [ prepare-env.sh ] first."
#   exit 1
# fi

terraform init
terraform validate
cp ../1.common-vars.auto.tfvars .
terraform plan  
terraform apply -auto-approve