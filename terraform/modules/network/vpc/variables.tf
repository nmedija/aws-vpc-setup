variable "name" { }

variable "cidr" { }

variable "tenancy" {
    default = "default"
}

variable "assign_ipv6_block" {
    default = "false"
}
