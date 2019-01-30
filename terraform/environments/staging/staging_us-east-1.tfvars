environment = "staging"

region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

public_subnets = {
  us-east-1a = "10.0.1.0/24"
  us-east-1b = "10.0.2.0/24"
  us-east-1c = "10.0.3.0/24"
  us-east-1d = "10.0.4.0/24"
  us-east-1e = "10.0.5.0/24"
}

management_subnets = {
  us-east-1a = "10.0.6.0/24"
  us-east-1b = "10.0.7.0/24"
  us-east-1c = "10.0.8.0/24"
  us-east-1d = "10.0.9.0/24"
  us-east-1e = "10.0.10.0/24"
}

application_subnets = {
  us-east-1a = "10.0.16.0/21"
  us-east-1b = "10.0.24.0/21"
  us-east-1c = "10.0.32.0/21"
  us-east-1d = "10.0.40.0/21"
  us-east-1e = "10.0.48.0/21"
}

storage_subnets = {
  us-east-1a = "10.0.56.0/22"
  us-east-1b = "10.0.64.0/22"
  us-east-1c = "10.0.72.0/22"
  us-east-1d = "10.0.80.0/22"
  us-east-1e = "10.0.88.0/22"
}

nat_gateway_count = 1

bastion_ami = "ami-43a15f3e"
