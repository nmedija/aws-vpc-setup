# aws-vpc-setup
An example of using Terraform to setup an AWS VPC

This relies on [terraform-modules](https://github.com/nmedija/terraform-modules) to create:
1. VPC
2. Private Subnets
3. Public Subnets
4. NAT Gateways
5. Bastion Host

## Pre-requisites
- Terraform

## Setup
1. Create the `secrets.tfvars` file with the AWS access key and secret key
```
aws_access_key = "**************"
aws_secret_key = "**************"
```
2. Set the AWS_PROFILE environment variable with the AWS credentials profile to use to authenticate with AWS. This is needed for the remote state setup to work.
```
export AWS_PROFILE=terraform-admin
```
3. Create the S3 bucket that will be used for Terraform State back-end
```
./bootstrap.bash
```
4. Run the `plan` command
```
./tf.bash plan
```
5. Run the `apply` command
```
./tf.bash apply
```
