variable "vpc_id" { }

variable "subnet_prefix" {
    default = "private"
}

variable "azs" {
    type = "list"
}

variable "cidrs"  {
    type = "map"
}

variable "nat_gateway_ids" {
    type = "list"
}

variable "nat_gateway_count" { }

variable "egress_only_gateway_id" { }
