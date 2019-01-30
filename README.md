# aws-vpc-setup
An example of using Terraform to setup an AWS VPC

This contains modules to create the an AWS VPC with:
1. Private Subnets
2. Public Subnets
3. NAT Gateways
4. Bastion Host

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
4. Run `terraform plan` command
```
./tf.bash plan
```
5. Run 'terraform apply' command
```
./tf.bash apply
```
