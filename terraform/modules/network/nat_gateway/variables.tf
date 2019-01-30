variable "prefix_name" {
    default = "nat"
}

variable "azs" {
    type = "list"
}

variable "public_subnet_ids" {
    type = "list"
}

variable "nat_gateway_count" {
    default = 1
}
