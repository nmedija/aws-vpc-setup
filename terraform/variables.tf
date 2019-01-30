variable "aws_access_key" { }

variable "aws_secret_key" { }

variable "aws_region" {
    default = "us-east-1"
}

variable "environment" {
    default = "staging"
}

variable "public_subnets" {
    type = "map"
}

variable "vpc_cidr" { }

variable "management_subnets" {
    type = "map"
}

variable "application_subnets" {
    type = "map"
}

variable "storage_subnets" {
    type = "map"
}

// NOTE: NAT gateways automatically cretes EIPs. Make sure the number of
//       EIP limits per VPC set for the account is not exceeded, otherwise an
//       AddressLimitExceeded would occur.
//       https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html
variable "nat_gateway_count" { }

variable "bastion_ami" { }
