terraform {
  backend "s3" {
    bucket = "caimito-terraform-state"
    region = "us-east-1"
    key = "terraform/terraform.tfstate"
  }
}
