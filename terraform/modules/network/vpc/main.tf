resource "aws_vpc" "vpc" {
    cidr_block = "${var.cidr}"
    instance_tenancy = "${var.tenancy}"
    enable_dns_support = true
    enable_dns_hostnames = true
    assign_generated_ipv6_cidr_block = "${var.assign_ipv6_block}"

    tags {
        Name = "${var.name}"
    }

    lifecycle {
        create_before_destroy = true
    }
}
