#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
DEBUG=${DEBUG:-N}
if [[ "$DEBUG" == "Y" ]]; then
    set -o xtrace
fi

# Get modules
if [ ! -d .terraform/modules ]; then
  terraform get terraform/tfstate-remote-setup
fi

# Initialize
if [ ! -e  .terraform/terraform.tfstate ]; then
  terraform init terraform/tfstate-remote-setup
fi

terraform apply \
    -var-file="secret.tfvars" \
    terraform/tfstate-remote-setup
