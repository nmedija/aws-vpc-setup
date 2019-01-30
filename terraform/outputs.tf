output "Environment" {
  value = <<CONFIG

  Environment Name: ${var.environment}
  Region:           ${var.aws_region}
CONFIG
}

output "Network" {
  value = <<CONFIG

  vpc_id:              ${module.vpc.vpc_id}
  vpc_cidr:            ${module.vpc.vpc_cidr}
  public_subnets:      ${join("\n                       ", formatlist("%s", module.public_subnet.subnet_ids))}
  management_subnets:  ${join("\n                       ", formatlist("%s", module.management_subnet.subnet_ids))}
  application_subnets: ${join("\n                       ", formatlist("%s", module.application_subnet.subnet_ids))}
  storage_subnets:     ${join("\n                       ", formatlist("%s", module.storage_subnet.subnet_ids))}
  bastion_public_ip    ${module.bastion.public_ip}
CONFIG
}
