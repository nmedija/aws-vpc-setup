resource "aws_subnet" "private" {
    vpc_id = "${var.vpc_id}"
    count = "${length(var.azs)}"
    cidr_block = "${lookup(var.cidrs, element(var.azs, count.index))}"
    availability_zone = "${element(var.azs, count.index)}"

    lifecycle {
        create_before_destroy = true
    }
    tags {
        Name = "${var.subnet_prefix}-${element(var.azs, count.index)}"
        Tier = "${var.subnet_prefix}"
    }
}

resource "aws_route_table" "private" {
    vpc_id = "${var.vpc_id}"
    count = "${var.nat_gateway_count}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${element(var.nat_gateway_ids, count.index)}"
    }

    route {
        ipv6_cidr_block = "::/0"
        egress_only_gateway_id = "${var.egress_only_gateway_id}"
    }

    tags {
        Name = "${var.subnet_prefix}-nat-route"
    }
}

resource "aws_route_table_association" "private" {
  count = "${length(var.cidrs)}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index % var.nat_gateway_count)}"
  lifecycle {
    create_before_destroy = true
  }
}
