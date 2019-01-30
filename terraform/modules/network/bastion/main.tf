resource "aws_security_group" "sg_bastion" {
    name        = "sg_bastion"
    description = "Allow SSH traffic only"
    vpc_id      = "${var.vpc_id}"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

data "template_file" "bootstrap" {
    template = "${file("${path.module}/bootstrap.bash.tpl")}"
    vars {
        hostname = "bastion-${var.environment}"
    }
}

resource "aws_instance" "bastion" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    subnet_id  = "${var.subnet_id}"
    associate_public_ip_address = true
    key_name = "caimito-ec2"
    vpc_security_group_ids = [ "${aws_security_group.sg_bastion.id}" ]
    source_dest_check = "true"
    user_data = "${data.template_file.bootstrap.rendered}"
    tags = {
        Name = "bastion-${var.environment}"
    }
}
