resource "aws_eip" "nat" {
    vpc   = true
    count = "${var.nat_gateway_count}"
    lifecycle { create_before_destroy = true }
}

resource "aws_nat_gateway" "nat" {
    count = "${var.nat_gateway_count}"
    allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
    subnet_id = "${element(var.public_subnet_ids, count.index)}"

    lifecycle {
        create_before_destroy = true
    }
    
    tags = {
        Name = "${var.prefix_name}-${element(var.azs, count.index)}"
    }
}
