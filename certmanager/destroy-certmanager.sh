#!/bin/bash

cp ../dns-zone-vars.auto.tfvars .
cp ../0.aws-creds.auto.tfvars .
cp ../1.common-vars.auto.tfvars .
cp ../2.cert-manager-vars.auto.tfvars .
terraform destroy -auto-approve