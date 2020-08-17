#!/bin/bash
cp ../0.aws-creds.auto.tfvars .
cp ../1.common-vars.auto.tfvars .
cp ../3.external-dns-vars.auto.tfvars .
terraform destroy -auto-approve