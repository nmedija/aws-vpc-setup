resource "aws_internet_gateway" "public" {
    vpc_id = "${var.vpc_id}"
    tags {
        Name = "${var.subnet_prefix}-igw"
    }
}

resource "aws_subnet" "public" {
    vpc_id = "${var.vpc_id}"
    count = "${length(var.azs)}"
    cidr_block = "${lookup(var.cidrs, element(var.azs, count.index))}"
    availability_zone = "${element(var.azs, count.index)}"
    map_public_ip_on_launch = true

    lifecycle {
        create_before_destroy = true
    }

    tags {
        Name = "${var.subnet_prefix}-${element(var.azs, count.index)}"
        Tier = "${var.subnet_prefix}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${var.vpc_id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.public.id}"
    }

    route {
        ipv6_cidr_block = "::/0"
        gateway_id = "${aws_internet_gateway.public.id}"
    }

    tags {
        Name = "${var.subnet_prefix}-igw-route"
    }
}

resource "aws_route_table_association" "public" {
    count = "${length(var.cidrs)}"
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"

    lifecycle {
        create_before_destroy = true
    }
}
