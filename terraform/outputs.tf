output "Environment" {
  value = <<CONFIG

  Environment Name: ${var.environment}
  Region:           ${var.aws_region}
CONFIG
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr}"
}

output "public_subnet_ids" {
  value = "${module.public_subnet.subnet_ids}"
}

output "management_subnet_ids" {
  value = "${module.management_subnet.subnet_ids}"
}

output "application_subnet_ids" {
  value = "${module.application_subnet.subnet_ids}"
}

output "storage_subnet_ids" {
  value = "${module.storage_subnet.subnet_ids}"
}

output "bastion_public_ip" {
  value = "${module.bastion.public_ip}"
}
