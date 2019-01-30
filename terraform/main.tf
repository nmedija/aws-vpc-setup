provider "aws" {
    region = "${var.aws_region}"
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"

    version = "~> 1.56"
}

# ----------------------------------
# Create the VPC for the environment
# ----------------------------------
module "vpc" {
    source = "./modules/network/vpc"

    name = "${var.environment}-vpc"
    cidr = "${var.vpc_cidr}"
}

# --------------
# Public Subnets
# --------------
module "public_subnet" {
    source = "./modules/network/public_subnet"

    subnet_prefix = "public"
    vpc_id = "${module.vpc.vpc_id}"
    azs = "${keys(var.public_subnets)}"
    cidrs = "${var.public_subnets}"
}

module "nat_gateway" {
    source = "./modules/network/nat_gateway"
    azs = "${keys(var.public_subnets)}"
    public_subnet_ids = "${module.public_subnet.subnet_ids}"
    nat_gateway_count = "${var.nat_gateway_count}"
}

# ---------------
# Private Subnets
# ---------------
resource "aws_egress_only_internet_gateway" "private" {
    vpc_id = "${module.vpc.vpc_id}"
}

module "management_subnet" {
    source = "./modules/network/private_subnet"

    subnet_prefix = "management"
    vpc_id = "${module.vpc.vpc_id}"
    azs = "${keys(var.management_subnets)}"
    cidrs = "${var.management_subnets}"
    nat_gateway_ids = "${module.nat_gateway.nat_gateway_ids}"
    nat_gateway_count = "${var.nat_gateway_count}"
    egress_only_gateway_id = "${aws_egress_only_internet_gateway.private.id}"
}

module "application_subnet" {
    source = "./modules/network/private_subnet"

    subnet_prefix = "application"
    vpc_id = "${module.vpc.vpc_id}"
    azs = "${keys(var.application_subnets)}"
    cidrs = "${var.application_subnets}"
    nat_gateway_ids = "${module.nat_gateway.nat_gateway_ids}"
    nat_gateway_count = "${var.nat_gateway_count}"
    egress_only_gateway_id = "${aws_egress_only_internet_gateway.private.id}"
}

module "storage_subnet" {
    source = "./modules/network/private_subnet"

    subnet_prefix = "storage"
    vpc_id = "${module.vpc.vpc_id}"
    azs = "${keys(var.storage_subnets)}"
    cidrs = "${var.storage_subnets}"
    nat_gateway_ids = "${module.nat_gateway.nat_gateway_ids}"
    nat_gateway_count = "${var.nat_gateway_count}"
    egress_only_gateway_id = "${aws_egress_only_internet_gateway.private.id}"
}

# ------------
# bastion host
# ------------
module "bastion" {
    source = "./modules/network/bastion"

    environment = "${var.environment}"
    vpc_id = "${module.vpc.vpc_id}"
    subnet_id = "${element(module.public_subnet.subnet_ids,0)}"
    ami = "${var.bastion_ami}"
}
