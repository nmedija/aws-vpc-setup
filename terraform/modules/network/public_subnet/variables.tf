variable "subnet_prefix" {
    default = "public"
}

variable "vpc_id" { }

variable "azs" {
    type = "list"
}

variable "cidrs" {
    type = "map"
}
