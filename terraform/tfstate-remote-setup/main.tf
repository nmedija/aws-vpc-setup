provider "aws" {
    region = "${var.aws_region}"
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"

    version = "~> 1.56"
}

resource "aws_s3_bucket" "terraform_state_bucket" {
    bucket = "caimito-terraform-state",
    acl = "private"
    versioning {
        enabled = "true"
    }
}
