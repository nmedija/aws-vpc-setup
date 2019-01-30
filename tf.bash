#!/usr/bin/env bash

option="${1:-plan}"
environment="${2:-staging}"

# Get modules
if [ ! -d .terraform/modules ]; then
  terraform get terraform
fi

# Initialize
if [ ! -e  .terraform/terraform.tfstate ]; then
  terraform init terraform
fi

shift 2
echo "Running $option on $environment..."
for file in $(find terraform/environments/"$environment"/*.tfvars -type f); do
  echo "$file"
  terraform "$option" \
    -var-file="$file" \
    -var-file="secret.tfvars" \
    terraform
done
